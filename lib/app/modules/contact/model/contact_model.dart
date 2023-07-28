import 'package:hive/hive.dart';
import 'package:uex/app/modules/contact/model/address_model.dart';
import 'package:uex/app/service/database.dart';

part 'contact_model.g.dart';

@HiveType(typeId: Database.contactHiveTypeId)
class ContactModel extends HiveObject{
  @HiveField(0)
  String name;

  @HiveField(1)
  String cpf;

  @HiveField(2)
  String email;


  @HiveField(3)
  AddressModel address = AddressModel();

  ContactModel({required this.name, required this.cpf, required this.email, required this.address});
}