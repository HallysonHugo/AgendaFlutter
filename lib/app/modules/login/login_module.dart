import 'package:flutter_modular/flutter_modular.dart';
import 'package:uex/app/modules/login/controller/login_controller.dart';
import 'package:uex/app/modules/login/repository/login_repository.dart';
import 'package:uex/app/modules/login/view/login_page.dart';
import 'package:uex/app/modules/login/view/sign_up_page.dart';

class LoginModule extends Module {
  static const String routeName = '/login';
  @override
  final List<Bind> binds = [
    Bind.factory((i) => LoginRepository()),
    Bind.factory((i) => LoginController(repository: i.get<LoginRepository>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(LoginPage.routeName, child: (_, args) => const LoginPage()),
    ChildRoute(SignUpPage.routeName, child: (_, args) => const SignUpPage()),
  ];
}