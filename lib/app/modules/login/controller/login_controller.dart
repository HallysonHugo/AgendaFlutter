import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:uex/app/modules/login/model/login_model.dart';
import 'package:uex/app/modules/login/repository/login_repository.dart';

part 'login_controller.g.dart';

@Injectable()
class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final LoginRepository repository;
  LoginControllerBase({required this.repository});

  @observable
  bool isLoginPasswordVisible = true;

  @observable
  bool isSignupPasswordVisible = true;




  Future<void>signup({required String email, required String password}) async{
    try{
      final String lowerCaseEmail = email.trim().toLowerCase();
      if(!lowerCaseEmail.contains('@')){
        throw 'Email inválido';
      }
      final LoginModel loginModel = LoginModel(email: lowerCaseEmail, password: password);
      await repository.signup(loginModel: loginModel);
    }
    catch(e){
      rethrow;
    }
  }


  Future<LoginModel>login({required String email, required String password}) async{
    try{
      final LoginModel loginModel = LoginModel(email: email, password: password);
      final LoginModel loginModelFromIsar = await repository.login(loginModel: loginModel);
      return loginModelFromIsar;
    }
    catch(e){
      rethrow;
    }
  }
}
