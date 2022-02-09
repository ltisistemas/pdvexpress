import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/entities/user_logged.dart';
import 'package:pdvexpress/app/core/domain/erros/error_user.dart';
import 'package:pdvexpress/app/modules/login/domain/repositories/login_repository.dart';

abstract class CadastrarUsuario {
  Future<Either<ErrorUser, UserLogged>> call(String nome, String email, String password);
}

class CadastrarUsuarioImpl implements CadastrarUsuario {
  final LoginRepository repository;

  CadastrarUsuarioImpl(this.repository);

  @override
  Future<Either<ErrorUser, UserLogged>> call(String nome, String email, String password) {
    return repository.signUp(nome, email, password);
  }
}