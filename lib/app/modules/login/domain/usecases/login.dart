import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/entities/user_logged.dart';
import 'package:pdvexpress/app/core/domain/erros/error_user.dart';
import 'package:pdvexpress/app/modules/login/domain/repositories/login_repository.dart';

abstract class Login {
  Future<Either<ErrorUser, UserLogged>> call(String? login, String? password);
}

class LoginImpl implements Login {

  final LoginRepository repository;

  LoginImpl(this.repository);

  @override
  Future<Either<ErrorUser, UserLogged>> call(String? login, String? password) {
    return repository.login(login!, password!);
  }

}