import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/entities/user_logged.dart';
import 'package:pdvexpress/app/core/domain/erros/error_user.dart';

abstract class LoginRepository {
  Future<Either<ErrorUser, UserLogged>> login(String login, String password);

  Future<Either<ErrorUser, UserLogged>> signUp(String nome, String email, String password);

  Future<Either<ErrorUser, UserLogged>> google();

  Future<Either<ErrorUser, bool>> signOut();

  Future<Either<ErrorUser, bool>> forgot(String email);
}