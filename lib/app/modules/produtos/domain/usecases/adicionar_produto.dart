import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/entities/produto.dart';
import 'package:pdvexpress/app/core/domain/erros/error_order.dart';
import 'package:pdvexpress/app/core/domain/repositories/produtos_repository.dart';

abstract class CadastrarProduto {
  Future<Either<ErrorOrder, Produto>> call(Map produto);
}

class CadastrarProdutoImpl implements CadastrarProduto {
  final ProdutoRepository repository;

  CadastrarProdutoImpl(this.repository);

  @override
  Future<Either<ErrorOrder, Produto>> call(Map produto) async {
    return repository.store(produto);
  }
}
