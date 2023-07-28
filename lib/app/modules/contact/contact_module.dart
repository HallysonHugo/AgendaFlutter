import 'package:flutter_modular/flutter_modular.dart';
import 'package:uex/app/modules/contact/model/contact_model.dart';
import 'package:uex/app/modules/contact/repository/contact_repository.dart';
import 'package:uex/app/modules/contact/view/list_contacts_page.dart';
import 'package:uex/app/service/database.dart';

import 'controller/contact_controller.dart';


class ContactModule extends Module {
  static const String routeName = '/contatos';
  @override
  final List<Bind> binds = [
    Bind.factory((i) => ContactRepository(database: i.get<Database<ContactModel>>())),
    Bind.lazySingleton((i) => ContactController(repository: i.get<ContactRepository>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(ListContactsPage.routeName, child: (_, args) => const ListContactsPage()),
  ];
}