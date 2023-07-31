import 'package:flutter_modular/flutter_modular.dart';
import 'package:uex/app/controller/app_controller.dart';
import 'package:uex/app/modules/contact/contact_module.dart';
import 'package:uex/app/modules/login/login_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AppController())
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(LoginModule.routeName, module: LoginModule()),
    ModuleRoute(ContactModule.routeName, module: ContactModule())
  ];
}