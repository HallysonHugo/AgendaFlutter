import 'package:flutter_modular/flutter_modular.dart';
import 'package:uex/app/modules/login/controller/login_controller.dart';
import 'package:uex/app/modules/login/view/login_page.dart';

class LoginModule extends Module {
  static const String routeName = '/login';
  @override
  final List<Bind> binds = [
    Bind.factory((i) => LoginController())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const LoginPage()),
  ];
}