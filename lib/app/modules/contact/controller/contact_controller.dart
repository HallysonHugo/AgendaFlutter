import 'package:brasil_fields/brasil_fields.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uex/app/modules/contact/model/address_model.dart';
import 'package:uex/app/modules/contact/repository/contact_repository.dart';
import '../model/contact_model.dart';

part 'contact_controller.g.dart';


@Injectable()
class ContactController = ContactControllerBase with _$ContactController;

abstract class ContactControllerBase with Store {
  final ContactRepository repository;
  ContactControllerBase({required this.repository});


  @observable
  List<ContactModel> contacts = [];

  List<ContactModel> allContacts = [];

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

  Future<List<AddressModel>>getListAddresses({required String search})async{
    try{
      await repository.getListAddresses(search: search);
      return [];
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
 }

 Future<void> deleteContact({required ContactModel contactModel})async{
   await contactModel.delete();
   await getContacts();
 }

 Future<void> getCoodinatesFromAddress({required AddressModel addressModel})async{
  // final addresses = await Geolocator();
 }
}