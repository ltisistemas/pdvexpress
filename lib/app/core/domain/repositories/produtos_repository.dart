import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/entities/produto.dart';
import 'package:pdvexpress/app/core/domain/erros/error_order.dart';

abstract class ProdutoRepository {
  Future<Either<ErrorOrder, Produto>> store(Map produto);
}