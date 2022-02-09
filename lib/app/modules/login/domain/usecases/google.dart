import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/entities/user_logged.dart';
import 'package:pdvexpress/app/core/domain/erros/error_user.dart';
import 'package:pdvexpress/app/modules/login/domain/repositories/login_repository.dart';
import 'package:pdvexpress/app/modules/login/domain/usecases/login.dart';

class GoogleImpl implements Login {

  final LoginRepository repository;

  GoogleImpl(this.repository);

  @override
  Future<Either<ErrorUser, UserLogged>> call(String? login, String? password) {
    return repository.google();
  }

}