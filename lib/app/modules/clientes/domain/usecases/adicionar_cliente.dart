import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/entities/cliente.dart';
import 'package:pdvexpress/app/core/domain/erros/error_order.dart';
import 'package:pdvexpress/app/core/domain/repositories/clientes_repository.dart';

abstract class CadastrarCliente {
  Future<Either<ErrorOrder, Cliente>> call(Map produto);
}

class CadastrarClienteImpl implements CadastrarCliente {
  final ClientesRepository repository;

  CadastrarClienteImpl(this.repository);

  @override
  Future<Either<ErrorOrder, Cliente>> call(Map cliente) async {
    return repository.store(cliente);
  }
}
