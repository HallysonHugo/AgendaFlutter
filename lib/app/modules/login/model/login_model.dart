import 'package:hive/hive.dart';
import 'package:uex/app/service/database.dart';
part 'login_model.g.dart';


@HiveType(typeId: Database.loginHiveTypeId)
class LoginModel extends HiveObject{
  @HiveField(0)
  String email;

  @HiveField(2)
  String password;

  LoginModel({required this.email, this.password = ''});
}