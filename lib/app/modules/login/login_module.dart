import 'package:flutter_modular/flutter_modular.dart';
import 'package:uex/app/modules/login/view/login_page.dart';

class LoginModule extends Module {
  static const String routeName = '/LoginModule';
  @override
  final List<Bind> binds = [
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => LoginPage()),
  ];
}