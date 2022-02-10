import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/erros/error_order.dart';
import 'package:pdvexpress/app/core/domain/repositories/clientes_repository.dart';

abstract class AtivarCliente {
  Future<Either<ErrorOrder, bool>> call(String uid);
}

class AtivarClienteImpl implements AtivarCliente {
  final ClientesRepository repository;

  AtivarClienteImpl(this.repository);

  @override
  Future<Either<ErrorOrder, bool>> call(String uid) async =>
      repository.activated(uid);
}
