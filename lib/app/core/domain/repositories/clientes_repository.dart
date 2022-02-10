import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/entities/cliente.dart';
import 'package:pdvexpress/app/core/domain/erros/error_order.dart';

abstract class ClientesRepository {
  Future<Either<ErrorOrder, Cliente>> store(Map cliente);

  Future<Either<ErrorOrder, Cliente>> update(Map cliente);

  Future<Either<ErrorOrder, bool>> destroy(String uid);

  Future<Either<ErrorOrder, bool>> activated(String uid);
}
