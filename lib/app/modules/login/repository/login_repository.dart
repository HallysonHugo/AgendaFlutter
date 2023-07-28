import 'package:uex/app/modules/login/model/login_model.dart';
import 'package:uex/app/service/database.dart';

class LoginRepository{
  Database<LoginModel> database = Database<LoginModel>();

  Future<void>signup({required LoginModel loginModel}) async{
    try{
      final loginBox = await database.box;
      loginBox.add(loginModel);
    }
    catch(e){
      rethrow;
    }
  }

  Future<LoginModel>login({required LoginModel loginModel}) async{
    try{
      final loginBox = await database.box;
      LoginModel loginDatabase = loginBox.values.firstWhere((element) => element.email.trim() == loginModel.email.trim());
      if(loginDatabase.encriptedPassword != loginModel.encriptedPassword){
        throw Exception('Senha incorreta');
      }
      return loginDatabase;
    }
    on StateError{
      throw Exception('Usuário não encontrado');
    }
  }
}