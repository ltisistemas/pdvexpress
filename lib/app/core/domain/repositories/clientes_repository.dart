import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/entities/cliente.dart';
import 'package:pdvexpress/app/core/domain/erros/error_order.dart';

abstract class ClientesRepository {
  Future<Either<ErrorOrder, Cliente>> store(Map produto);
}
