import 'package:dio/dio.dart';
import 'package:geocoder_buddy/geocoder_buddy.dart';
import 'package:uex/app/modules/contact/model/address_model.dart';
import 'package:uex/app/modules/contact/model/contact_model.dart';
import 'package:uex/app/service/custom_dio.dart';
import 'package:uex/app/service/database.dart';

class ContactRepository{
  final Database database = Database();
  final CustomDio dio = CustomDio();

  Future<AddressModel>getAddress({required String cep})async{
    Response response = await dio.instance.get('https://viacep.com.br/ws/$cep/json');
    AddressModel addressModel = AddressModel.fromJson(response.data);
    return addressModel;
  }

  Future<void> saveContacts({required ContactModel contactModel})async{
    try{
      final contactBox = await database.contactBox;
      if(contactBox.values.any((element) => element.cpf == contactModel.cpf)){
        throw 'CPF já cadastrado';
      }
      contactBox.add(contactModel);
    }
    catch(e){
      rethrow;
    }
  }

  Future<List<GBSearchData>> getListAddresses({required String search})async{
    try{
      final response = await GeocoderBuddy.query(search);
      return response;
    }
    catch(e){
      rethrow;
    }
  }

  Future<void> updateContact({required ContactModel contactModel})async{
    try{
      await contactModel.save();
    }
    catch(e){
      rethrow;
    }
  }

  Future<List<ContactModel>> getContacts() async{
    try{
      final contactBox = await database.contactBox;
      return contactBox.values.toList();
    }
    catch(e){
      rethrow;
    }
  }
}