
import 'dart:convert';

import 'package:isar/isar.dart';
part 'login_model.g.dart';

@collection
class LoginModel{
  
  Id id = Isar.autoIncrement;

  late String email;

  @ignore
  late String password;

  String get encriptedPassword => const Base64Encoder().convert(utf8.encode(password));
}