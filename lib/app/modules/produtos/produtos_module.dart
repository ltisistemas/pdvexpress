import 'package:flutter_modular/flutter_modular.dart';
import 'package:pdvexpress/app/core/domain/guards/auth_guard.dart';
import 'package:pdvexpress/app/core/external/datasources/produto_datasource_impl.dart';
import 'package:pdvexpress/app/core/infra/repositories/produtos_repository_impl.dart';
import 'package:pdvexpress/app/modules/produtos/domain/presenter/produtos_page.dart';
import 'package:pdvexpress/app/modules/produtos/domain/presenter/produtos_store.dart';
import 'package:pdvexpress/app/modules/produtos/domain/usecases/adicionar_produto.dart';
import 'package:pdvexpress/app/modules/produtos/domain/usecases/ativar_produto.dart';
import 'package:pdvexpress/app/modules/produtos/domain/usecases/atualizar_produto.dart';
import 'package:pdvexpress/app/modules/produtos/domain/usecases/excluir_produto.dart';

class ProdutosModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProdutosStore()),
    Bind.lazySingleton((i) => ProdutoDatasourceImpl()),
    Bind.lazySingleton((i) => ProdutoRepositoryImpl(i.get<ProdutoDatasourceImpl>())),

    Bind.lazySingleton((i) => CadastrarProdutoImpl(i.get<ProdutoRepositoryImpl>())),
    Bind.lazySingleton((i) => AtualizarProdutoImpl(i.get<ProdutoRepositoryImpl>())),
    Bind.lazySingleton((i) => AtivarProdutoImpl(i.get<ProdutoRepositoryImpl>())),
    Bind.lazySingleton((i) => ExcluirProdutoImpl(i.get<ProdutoRepositoryImpl>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const ProdutosHome(), guards: [AuthGuard()]),
  ];
}