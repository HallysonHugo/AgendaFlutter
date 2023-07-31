import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uex/app/app_widget.dart';
import 'package:uex/app/modules/contact/model/address_model.dart';
import 'package:uex/app/modules/contact/model/contact_model.dart';
import 'package:uex/app/modules/login/model/login_model.dart';

import 'app/app_module.dart';
import 'app/modules/login/login_module.dart';
import 'app/modules/login/view/login_page.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  Hive.registerAdapter(LoginModelAdapter());
  Hive.registerAdapter(AddressModelAdapter());
  Hive.registerAdapter(ContactModelAdapter());
  await Hive.initFlutter();
  Modular.setInitialRoute(LoginModule.routeName + LoginPage.routeName);
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    )
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}