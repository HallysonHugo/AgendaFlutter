import 'package:uex/app/service/custom_dio.dart';
import 'package:uex/app/service/database.dart';

import '../modules/login/model/login_model.dart';

class AppRepository{
  final Database database = Database();
  final CustomDio dio = CustomDio();


  Future<void> deleteUser({required LoginModel loginModel})async{
    try{
      final loginBox = await database.loginBox;
      loginBox.delete(loginModel.key);
    }
    catch(e){
      rethrow;
    }
  }
}