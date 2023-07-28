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

  Future<void> saveContacts({required String name, required String cpf, required String email, required AddressModel address})async{
    final ContactModel contactModel = ContactModel(name: name, cpf: cpf, email: email, address: address);
    await repository.saveContacts(contactModel: contactModel);
  }

  Future<void> updateContact({required ContactModel contactModel})async{
    await repository.updateContact(contactModel: contactModel);
  }

  Future<List<ContactModel>> getContacts() async{
    return await repository.getContacts();
 }
}