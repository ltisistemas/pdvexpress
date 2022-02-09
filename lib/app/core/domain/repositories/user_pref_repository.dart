import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/entities/user_logged.dart';
import 'package:pdvexpress/app/core/domain/erros/error_user.dart';

abstract class UserPrefsRepository {
  Future<Either<ErrorUser, UserLogged>> getUser();

  Future<void> setUser(Map<String, dynamic> user);

  Future<Either<ErrorUser, bool>> deleteUser();
}
