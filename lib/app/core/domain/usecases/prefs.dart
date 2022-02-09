import 'package:pdvexpress/app/core/domain/repositories/prefs_repository.dart';

abstract class Prefs {
  Future<bool> getBool(String key);

  void setBool(String key, bool b);

  Future<int> getInt(String key);

  void setInt(String key, int b);

  Future<String> getString(String key);

  void setString(String key, String b);

  void remove(String key);
}

class PrefsImpl implements Prefs {
  final PrefsRepository repository;

  PrefsImpl(this.repository);

  @override
  Future<bool> getBool(String key) => repository.getBool(key);

  @override
  void setBool(String key, bool b) => repository.setBool(key, b);

  @override
  Future<int> getInt(String key) => repository.getInt(key);

  @override
  void setInt(String key, int b) => repository.setInt(key, b);

  @override
  Future<String> getString(String key) => repository.getString(key);

  @override
  void setString(String key, String b) => repository.setString(key, b);

  @override
  void remove(String key) => repository.remove(key);
}
