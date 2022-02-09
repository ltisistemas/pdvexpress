import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/entities/api_response.dart';
import 'package:pdvexpress/app/core/domain/entities/produto.dart';
import 'package:pdvexpress/app/core/domain/erros/error_order.dart';
import 'package:pdvexpress/app/core/domain/repositories/produtos_repository.dart';
import 'package:pdvexpress/app/core/infra/datasources/produto_datasource.dart';
import 'package:pdvexpress/app/core/infra/models/produto_model.dart';

class ProdutoRepositoryImpl implements ProdutoRepository {
  final ProdutoDatasource datasource;

  ProdutoRepositoryImpl(this.datasource);

  @override
  Future<Either<ErrorOrder, Produto>> store(Map produto) async {
    try {
      final model = ProdutoModel.fromJson(produto);
      final ApiResponse resultSet = await datasource.store(model);
      if (resultSet.ok) {
        return Right(resultSet.result);
      }

      return Left(ErrorOrderNotFound());
    } catch (e) {
      print('----> Repo');
      print(e);
      return Left(ErrorOrderFailure());
    }
  }
}
