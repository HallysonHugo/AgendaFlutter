import 'package:isar/isar.dart';

part 'contact_model.g.dart';

@collection
class ContactModel{
  Id id = Isar.autoIncrement;
  late String name;
  late String cpf;
  late String email;
  late String phone;
  late String address;
}