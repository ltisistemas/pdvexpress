import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/entities/api_response.dart';
import 'package:pdvexpress/app/core/domain/entities/cliente.dart';
import 'package:pdvexpress/app/core/domain/entities/produto.dart';
import 'package:pdvexpress/app/core/domain/erros/error_order.dart';
import 'package:pdvexpress/app/core/domain/repositories/clientes_repository.dart';
import 'package:pdvexpress/app/core/infra/datasources/clientes_datasource.dart';
import 'package:pdvexpress/app/core/infra/models/cliente_model.dart';

class ClientesRepositoryImpl implements ClientesRepository {
  final ClientesDatasource datasource;

  ClientesRepositoryImpl(this.datasource);

  @override
  Future<Either<ErrorOrder, Cliente>> store(Map cliente) async {
    try {
      final model = ClienteModel.fromJson(cliente);
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
