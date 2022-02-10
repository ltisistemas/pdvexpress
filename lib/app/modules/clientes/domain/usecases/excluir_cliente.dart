import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/erros/error_order.dart';
import 'package:pdvexpress/app/core/domain/repositories/clientes_repository.dart';

abstract class ExcluirCliente {
  Future<Either<ErrorOrder, bool>> call(String uid);
}

class ExcluirClienteImpl implements ExcluirCliente {
  final ClientesRepository repository;

  ExcluirClienteImpl(this.repository);

  @override
  Future<Either<ErrorOrder, bool>> call(String uid) async =>
      repository.destroy(uid);
}
