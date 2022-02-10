import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/entities/cliente.dart';
import 'package:pdvexpress/app/core/domain/erros/error_order.dart';
import 'package:pdvexpress/app/core/domain/repositories/clientes_repository.dart';

abstract class AtualizarCliente {
  Future<Either<ErrorOrder, Cliente>> call(Map cliente);
}

class AtualizarClienteImpl implements AtualizarCliente {
  final ClientesRepository repository;

  AtualizarClienteImpl(this.repository);

  @override
  Future<Either<ErrorOrder, Cliente>> call(Map cliente) async =>
      repository.update(cliente);
}
