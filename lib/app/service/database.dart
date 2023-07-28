import 'package:hive_flutter/hive_flutter.dart';

class Database<T>{

  static const int loginHiveTypeId = 0;
  static const int contactHiveTypeId = 1;

  Future<Box<T>> get box async => Hive.isBoxOpen(T.runtimeType.toString()) ? 
    Hive.box<T>(T.runtimeType.toString()) : 
    await Hive.openBox<T>(T.runtimeType.toString());
}