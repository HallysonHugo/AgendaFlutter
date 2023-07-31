import 'package:flutter_modular/flutter_modular.dart';
import 'package:uex/app/controller/app_controller.dart';
import 'package:uex/app/modules/contact/contact_module.dart';
import 'package:uex/app/modules/login/login_module.dart';
import 'package:uex/app/repository/app_repository.dart';
import 'package:uex/app/router_guard.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => AppRepository()),
    Bind.lazySingleton((i) => AppController(repository: i.get<AppRepository>()))
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(LoginModule.routeName, module: LoginModule()),
    ModuleRoute(ContactModule.routeName, module: ContactModule(), guards: [AuthGuard()])
  ];
}