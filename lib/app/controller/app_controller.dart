import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:uex/app/modules/login/model/login_model.dart';

part 'app_controller.g.dart';

@Injectable()
class AppController = AppControllerBase with _$AppController;

abstract class AppControllerBase with Store{

  LoginModel? loggedUser;

}