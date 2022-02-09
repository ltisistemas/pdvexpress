import 'package:flutter_modular/flutter_modular.dart';
import 'package:pdvexpress/app/core/domain/usecases/prefs.dart';
import 'package:pdvexpress/app/core/domain/usecases/user_prefs.dart';
import 'package:pdvexpress/app/core/infra/repositories/dio_repository.dart';
import 'package:pdvexpress/app/core/infra/repositories/prefs_repository_impl.dart';
import 'package:pdvexpress/app/core/infra/repositories/user_prefs_repository_impl.dart';
import 'package:pdvexpress/app/modules/clientes/clientes_module.dart';
import 'package:pdvexpress/app/modules/home/home_module.dart';
import 'package:pdvexpress/app/modules/login/login_module.dart';
import 'package:pdvexpress/app/modules/produtos/produtos_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => PrefsImpl(i())),
    Bind((i) => UserPrefsRepositoryImpl()),
    Bind((i) => UserPrefsImpl(i.get<UserPrefsRepositoryImpl>())),
    Bind((i) => PrefsRepositoryImpl()),
    Bind((i) => DioRepository(i.get<UserPrefsImpl>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/produtos', module: ProdutosModule()),
    ModuleRoute('/clientes', module: ClientesModule()),
  ];

}