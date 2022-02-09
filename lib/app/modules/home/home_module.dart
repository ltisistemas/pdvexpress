// LoginDatasourceImpl
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pdvexpress/app/core/domain/guards/auth_guard.dart';
import 'package:pdvexpress/app/modules/home/domain/presenter/components/drawer/drawer_store.dart';
import 'package:pdvexpress/app/modules/home/domain/presenter/home_page.dart';
import 'package:pdvexpress/app/modules/home/domain/presenter/home_store.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DrawerCtrl()),
    Bind.lazySingleton((i) => HomeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage(), guards: [AuthGuard()]),
  ];
}