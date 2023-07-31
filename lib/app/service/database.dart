import 'package:hive_flutter/hive_flutter.dart';
import 'package:uex/app/modules/contact/model/contact_model.dart';
import 'package:uex/app/modules/login/model/login_model.dart';

class Database<T>{

  static const int loginHiveTypeId = 0;
  static const int contactHiveTypeId = 1;
  static const int adressHiveTypeId = 2;


  Future<Box<LoginModel>> get loginBox async => Hive.isBoxOpen('login') ? Hive.box<LoginModel>('login') : await Hive.openBox<LoginModel>('login');
  
  Future<Box<ContactModel>> get contactBox async => Hive.isBoxOpen('contact') ? Hive.box<ContactModel>('contact') : await Hive.openBox<ContactModel>('contact');

}