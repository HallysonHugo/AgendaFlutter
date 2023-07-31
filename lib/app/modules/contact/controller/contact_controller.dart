import 'package:brasil_fields/brasil_fields.dart';
import 'package:geocoder_buddy/geocoder_buddy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uex/app/modules/contact/model/address_model.dart';
import 'package:uex/app/modules/contact/repository/contact_repository.dart';
import '../model/contact_model.dart';
import '../model/enum_contact_list_order.dart';

part 'contact_controller.g.dart';


@Injectable()
class ContactController = ContactControllerBase with _$ContactController;

abstract class ContactControllerBase with Store {
  final ContactRepository repository;
  ContactControllerBase({required this.repository});


  @observable
  List<ContactModel> contacts = [];

  List<ContactModel> allContacts = [];

  ContactListOrder contactListOrder = ContactListOrder.asc;


  late GoogleMapController mapController;
  Set<Marker> markers = {};

  Future<AddressModel>getAddress({required String cep})async{
    try{
      final cepWithoutMask = cep.replaceAll(RegExp(r'[^0-9]'), '');
      final AddressModel addressModel = await repository.getAddress(cep: cepWithoutMask);
      return addressModel;
    }
    catch(e){
      rethrow;
    }
  }

  void orderContacts(){
    if(contactListOrder == ContactListOrder.asc){
      contacts.sort((a, b) => b.name.compareTo(a.name));
      contactListOrder = ContactListOrder.dsc;
      return;
    }
    contacts.sort((a, b) => a.name.compareTo(b.name));
    contactListOrder = ContactListOrder.asc;
  }

  void markContact({required ContactModel contact}){
    for (ContactModel element in contacts) {
      if(element != contact){
        element.selected = false;
        }
      }
      contact.selected = true;
      mapController.animateCamera(
        CameraUpdate.newLatLng(LatLng(double.parse(contact.address.latitude), 
        double.parse(contact.address.longitude))));
      markers.add(Marker(
        markerId: MarkerId(contact.cpf),
        position: LatLng(double.parse(contact.address.latitude), double.parse(contact.address.longitude)),
        infoWindow: InfoWindow(
          title: contact.name,
          snippet: contact.address.logradouro,
        ),
      ));

  }

  Future<List<GBSearchData>>getListAddresses({required String search})async{
    try{
      return await repository.getListAddresses(search: search);
    }
    catch(e){
      rethrow;
    }
  }


  void searchContacts({required String search}){
    if(search.isEmpty){
      contacts = allContacts;
    }
    else{
      contacts = allContacts.where((element) => 
      element.name.toLowerCase().contains(search.toLowerCase()) ||
      element.cpf.contains(search) ||
      element.address.logradouro.contains(search)||
      element.address.bairro.contains(search)).toList();
      contacts.sort((a, b) => a.name.compareTo(b.name));
    }
    // setAllContactsMarker(contacts: contacts);
  }

  void validations({String name = '', String cpf = '',  String phone = '', String cep = '', String numero = '', String endereco = ''}){
    if(name.isEmpty){
      throw 'Nome não pode ser vazio';
    }
    if(cpf.isEmpty){
      throw 'CPF não pode ser vazio';
    }
    if(phone.isEmpty){
      throw 'Telefone não pode ser vazio';
    }
    if(endereco.isEmpty){
      throw 'Endereço não pode ser vazio';
    }
    if(cep.isEmpty){
      throw 'CEP não pode ser vazio';
    }
    if(numero.isEmpty){
      throw 'Número não pode ser vazio';
    }
  }


  void setAllContactsMarker({required List<ContactModel> contacts}){
    markers = {};
    contacts.forEach((element) {
      markers.add(Marker(
        markerId: MarkerId(element.toString()),
        position: LatLng(double.parse(element.address.latitude), double.parse(element.address.latitude)),
        infoWindow: InfoWindow(
          title: element.name,
          snippet: element.address.logradouro,
        ),
      ));
    });
  }

  Future<void> saveContacts({required String name, required String cpf,required String telefone ,required AddressModel address})async{
    if(!UtilBrasilFields.isCPFValido(cpf)){
      throw 'CPF inválido';
    }
    final ContactModel contactModel = ContactModel(name: name, cpf: cpf, address: address, telefone: telefone);
    await repository.saveContacts(contactModel: contactModel);
  }

  Future<void> updateContact({required ContactModel contactModel})async{
    await repository.updateContact(contactModel: contactModel);
  }

  Future<void> getContacts() async{
    contacts = await repository.getContacts();
    contacts.sort((a, b) => a.name.compareTo(b.name));
    allContacts = contacts;
    // setAllContactsMarker(contacts: contacts);
 }

 Future<void> deleteContact({required ContactModel contactModel})async{
   await contactModel.delete();
   await getContacts();
 }

 Future<void> getCoodinatesFromAddress({required AddressModel addressModel})async{
  // final addresses = await Geolocator();
 }
}