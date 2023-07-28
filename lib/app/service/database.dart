import 'package:isar/isar.dart';
import 'package:uex/app/modules/contact/model/contact_model.dart';
import 'package:uex/app/modules/login/model/login_model.dart';

class Database{
  final Isar isar = Isar.getInstance()!;

  Future<void> init() async{
    await Isar.open([
      LoginModelSchema,
      ContactModelSchema
    ], directory: '');
  }
}