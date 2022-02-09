import 'dart:async';

import 'package:pdvexpress/app/core/domain/repositories/prefs_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsRepositoryImpl implements PrefsRepository {
  @override
  Future<bool> getBool(String key) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getBool(key) ?? false;
  }

  @override
  void setBool(String key, bool b) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setBool(key, b);
  }

  @override
  Future<int> getInt(String key) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getInt(key) ?? 0;
  }

  @override
  void setInt(String key, int b) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setInt(key, b);
  }

  @override
  Future<String> getString(String key) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getString(key) ?? '';
  }

  @override
  void setString(String key, String b) async {
    var prefs = await SharedPreferences.getInstance();

    remove(key);
    await prefs.setString(key, b);
  }

  @override
  void remove(String key) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.remove(key);
  }
}
