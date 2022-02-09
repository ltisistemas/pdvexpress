import 'package:flutter_modular/flutter_modular.dart';
import 'package:pdvexpress/app/core/domain/usecases/user_prefs.dart';
import 'package:pdvexpress/app/core/infra/repositories/dio_repository.dart';
import 'package:pdvexpress/app/modules/login/domain/presenter/login_page.dart';
import 'package:pdvexpress/app/modules/login/domain/presenter/login_store.dart';
import 'package:pdvexpress/app/modules/login/domain/usecases/cadastrar_usuario.dart';
import 'package:pdvexpress/app/modules/login/domain/usecases/deslogar.dart';
import 'package:pdvexpress/app/modules/login/domain/usecases/esqueci_minha_senha.dart';
import 'package:pdvexpress/app/modules/login/domain/usecases/google.dart';
import 'package:pdvexpress/app/modules/login/domain/usecases/login.dart';
import 'package:pdvexpress/app/modules/login/external/datasources/login_datasource_impl.dart';
import 'package:pdvexpress/app/modules/login/infra/repositories/login_repository_impl.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginDatasourceImpl(i.get<DioRepository>())),
    Bind.lazySingleton((i) => LoginRepositoryImpl(i.get<LoginDatasourceImpl>(), i.get<UserPrefsImpl>())),
    Bind.lazySingleton((i) => LoginImpl(i())),
    Bind.lazySingleton((i) => GoogleImpl(i())),
    Bind.lazySingleton((i) => LoginStore()),
    Bind.lazySingleton((i) => CadastrarUsuarioImpl(i.get<LoginRepositoryImpl>())),
    Bind.lazySingleton((i) => DeslogarImpl(i.get<LoginRepositoryImpl>())),
    Bind.lazySingleton((i) => EsqueciMinhaSenhaImpl(i.get<LoginRepositoryImpl>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const LoginPage()),
  ];
}