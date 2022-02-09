import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/entities/user_logged.dart';
import 'package:pdvexpress/app/core/domain/erros/error_user.dart';
import 'package:pdvexpress/app/core/domain/repositories/user_pref_repository.dart';

abstract class UserPrefs {
  Future<Either<ErrorUser, UserLogged>> getUser();

  Future<void> setUser(Map<String, dynamic> user);

  Future<Either<ErrorUser, bool>> deleteUser();
}

class UserPrefsImpl implements UserPrefs {
  final UserPrefsRepository repository;

  UserPrefsImpl(this.repository);

  @override
  Future<Either<ErrorUser, bool>> deleteUser() async => repository.deleteUser();

  @override
  Future<Either<ErrorUser, UserLogged>> getUser() async => repository.getUser();

  @override
  Future<void> setUser(Map<String, dynamic> user) async =>
      repository.setUser(user);
}
