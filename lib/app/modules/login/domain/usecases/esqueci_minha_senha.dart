import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/erros/error_user.dart';
import 'package:pdvexpress/app/modules/login/domain/repositories/login_repository.dart';

abstract class EsqueciMinhaSenha {
  Future<Either<ErrorUser, bool>> call(String email);
}

class EsqueciMinhaSenhaImpl implements EsqueciMinhaSenha {
  final LoginRepository repository;

  EsqueciMinhaSenhaImpl(this.repository);

  @override
  Future<Either<ErrorUser, bool>> call(String email) => repository.forgot(email);
}