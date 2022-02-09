import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/erros/error_user.dart';
import 'package:pdvexpress/app/modules/login/domain/repositories/login_repository.dart';

abstract class Deslogar {
  Future<Either<ErrorUser, bool>> call();
}

class DeslogarImpl implements Deslogar {
  final LoginRepository repository;

  DeslogarImpl(this.repository);

  @override
  Future<Either<ErrorUser, bool>> call() => repository.signOut();
}