import 'package:uex/app/modules/contact/model/contact_model.dart';
import 'package:uex/app/service/database.dart';

class ContactRepository{
  final Database<ContactModel> database;
  ContactRepository({required this.database});


  Future<void> saveContacts({required ContactModel contactModel})async{
    try{
      final contactBox = await database.box;
      if(contactBox.values.any((element) => element.cpf == contactModel.cpf)){
        throw Exception('CPF já cadastrado');
      }
      contactBox.add(contactModel);
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
      final contactBox = await database.box;
      return contactBox.values.toList();
    }
    catch(e){
      rethrow;
    }
  }
}