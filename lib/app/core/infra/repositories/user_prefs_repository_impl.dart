import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pdvexpress/app/core/domain/entities/user_logged.dart';
import 'package:pdvexpress/app/core/domain/erros/error_user.dart';
import 'package:pdvexpress/app/core/domain/repositories/user_pref_repository.dart';
import 'package:pdvexpress/app/core/domain/usecases/prefs.dart';
import 'package:pdvexpress/app/core/infra/models/user_logged_model.dart';
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class UserPrefsRepositoryImpl implements UserPrefsRepository {
  final Prefs prefs = Modular.get<PrefsImpl>();

  @override
  Future<Either<ErrorUser, bool>> deleteUser() async {
    try {
      String json = await prefs.getString('user.logged');
      if (json.isNotEmpty) {
        prefs.remove('user.logged');

        return right(true);
      }

      return right(true);
    } catch (e) {
      return left(ErrorUserLoginFailure());
    }
  }

  @override
  Future<Either<ErrorUser, UserLogged>> getUser() async {
    var pref = await SharedPreferences.getInstance();

    try {
      String json = pref.getString('user.logged') ?? '';
      if (json.isEmpty) {
        return Left(ErrorUserNotFound());
      }

      final user = UserLoggedModel.fromPref(convert.json.decode(json));
      return right(user);
    } catch (e) {
      return left(ErrorUserNotFound());
    }
  }

  @override
  Future<void> setUser(Map<String, dynamic> user) async {
    var pref = await SharedPreferences.getInstance();

    String json = convert.json.encode(user);

    pref.setString('user.logged', json);
  }
}
