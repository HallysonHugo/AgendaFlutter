import 'package:flutter_modular/flutter_modular.dart';
import 'package:uex/app/controller/app_controller.dart';
import 'package:uex/app/modules/login/login_module.dart';
import 'package:uex/app/modules/login/view/login_page.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: LoginModule.routeName + LoginPage.routeName);

  @override
  Future<bool> canActivate(String path, ModularRoute router) {
    return Modular.get<AppController>().isLogged ? Future.value(true) : Future.value(false);
  }
}