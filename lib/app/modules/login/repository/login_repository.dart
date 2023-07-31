import 'package:uex/app/modules/login/model/login_model.dart';
import 'package:uex/app/service/database.dart';

class LoginRepository{
  Database database = Database();

  Future<void>signup({required LoginModel loginModel}) async{
    try{
      final loginBox = await database.loginBox;
      loginBox.add(loginModel);
    }
    catch(e){
      rethrow;
    }
  }

  Future<LoginModel>login({required LoginModel loginModel}) async{
    try{
      final loginBox = await database.loginBox;
      if(loginBox.isEmpty){
        throw 'Não foi possivel encontrar o cadastro com esse email';
      }
      LoginModel loginDatabase = loginBox.values.firstWhere((element) => 
      element.email.trim().toLowerCase() == loginModel.email.trim().toLowerCase());
      if(loginDatabase.encriptedPassword != loginModel.encriptedPassword){
        throw 'Senha incorreta';
      }
      return loginDatabase;
    }
    on StateError{
      throw 'Usuário não encontrado';
    }
    catch(e){
      throw e.toString();
    }
  }
}