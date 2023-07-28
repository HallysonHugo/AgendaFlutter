import 'package:flutter_modular/flutter_modular.dart';
import 'package:uex/app/modules/login/login_module.dart';
import 'package:uex/app/service/custom_dio.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CustomDio()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(LoginModule.routeName, module: LoginModule())
  ];
}