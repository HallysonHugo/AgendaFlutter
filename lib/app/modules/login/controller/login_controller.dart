import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

@Injectable()
class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  
}
