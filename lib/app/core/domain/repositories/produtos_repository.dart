import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/entities/produto.dart';
import 'package:pdvexpress/app/core/domain/erros/error_order.dart';

abstract class ProdutoRepository {
  Future<Either<ErrorOrder, Produto>> store(Map produto);

  Future<Either<ErrorOrder, Produto>> update(Map produto);

  Future<Either<ErrorOrder, bool>> destroy(String uid);

  Future<Either<ErrorOrder, bool>> activated(String uid);
}