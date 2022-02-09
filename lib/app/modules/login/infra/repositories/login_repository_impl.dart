import 'package:dartz/dartz.dart';
import 'dart:convert' as convert;
import 'package:pdvexpress/app/core/domain/entities/api_response.dart';
import 'package:pdvexpress/app/core/domain/entities/user_logged.dart';
import 'package:pdvexpress/app/core/domain/erros/error_user.dart';
import 'package:pdvexpress/app/core/domain/usecases/user_prefs.dart';
import 'package:pdvexpress/app/core/infra/models/user_logged_model.dart';
import 'package:pdvexpress/app/modules/login/domain/repositories/login_repository.dart';
import 'package:pdvexpress/app/modules/login/infra/datasources/login_datasource.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDatasource datasource;
  final UserPrefs userPrefs;

  LoginRepositoryImpl(this.datasource, this.userPrefs);

  @override
  Future<Either<ErrorUser, bool>> forgot(String email) async {
    try {
      await datasource.forgot(email);
      return const Right(true);
    } catch (e) {
      print('---> Repository');
      print(e);
      return Left(ErrorUserLoginFailure());
    }
  }

  @override
  Future<Either<ErrorUser, UserLogged>> login(String login, String password) async {
    try {
      final ApiResponse resultSet = await datasource.login(login, password);
      if (resultSet.ok) {
        final user = resultSet.result as UserLoggedModel;

        userPrefs.setUser(user.toJson());

        return Right(resultSet.result);
      }

      return Left(ErrorUserNotFound());
    } catch (e) {
      print('---> Repository');
      print(e);
      return Left(ErrorUserLoginFailure());
    }
  }
  @override
  Future<Either<ErrorUser, UserLogged>> google() async {
    try {
      final ApiResponse resultSet = await datasource.google();
      if (resultSet.ok) {
        final user = resultSet.result as UserLoggedModel;

        await userPrefs.deleteUser();

        await userPrefs.setUser(user.toJson());

        return Right(resultSet.result);
      }

      return Left(ErrorUserNotFound());
    } catch (e) {
      print('---> Repository');
      print(e);
      return Left(ErrorUserLoginFailure());
    }
  }

  @override
  Future<Either<ErrorUser, UserLogged>> signUp(String nome, String email, String password) async {
    try {
      final ApiResponse resultSet = await datasource.signUp(nome, email, password);
      if (resultSet.ok) {
        final user = resultSet.result as UserLoggedModel;

        userPrefs.setUser(user.toJson());

        return Right(resultSet.result);
      }

      return Left(ErrorUserNotFound());
    } catch (e) {
      print('---> Repository');
      print(e);
      return Left(ErrorUserLoginFailure());
    }
  }

  @override
  Future<Either<ErrorUser, bool>> signOut() async {
    try {
      await datasource.signOut();
      return const Right(true);
    } catch (e) {
      print('---> Repository');
      print(e);
      return Left(ErrorUserLoginFailure());
    }
  }
}