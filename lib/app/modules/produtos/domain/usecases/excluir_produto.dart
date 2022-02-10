import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/erros/error_order.dart';
import 'package:pdvexpress/app/core/domain/repositories/produtos_repository.dart';

abstract class ExcluirProduto {
  Future<Either<ErrorOrder, bool>> call(String uid);
}

class ExcluirProdutoImpl implements ExcluirProduto {
  final ProdutoRepository repository;

  ExcluirProdutoImpl(this.repository);

  @override
  Future<Either<ErrorOrder, bool>> call(String uid) async => repository.destroy(uid);
}
