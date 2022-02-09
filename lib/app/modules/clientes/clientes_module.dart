import 'package:flutter_modular/flutter_modular.dart';
import 'package:pdvexpress/app/core/domain/guards/auth_guard.dart';
import 'package:pdvexpress/app/core/external/datasources/clientes_datasource_impl.dart';
import 'package:pdvexpress/app/core/infra/repositories/clientes_repository_impl.dart';
import 'package:pdvexpress/app/modules/clientes/domain/presenter/clientes_page.dart';
import 'package:pdvexpress/app/modules/clientes/domain/presenter/clientes_store.dart';
import 'package:pdvexpress/app/modules/clientes/domain/usecases/adicionar_cliente.dart';

class ClientesModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ClientesStore()),
    Bind.lazySingleton((i) => ClientesDatasourceImpl()),
    Bind.lazySingleton(
        (i) => ClientesRepositoryImpl(i.get<ClientesDatasourceImpl>())),
    Bind.lazySingleton(
        (i) => CadastrarClienteImpl(i.get<ClientesRepositoryImpl>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const ClientesHome(), guards: [AuthGuard()]),
  ];
}
