import 'dart:async';

abstract class PrefsRepository {
  Future<bool> getBool(String key);
  void setBool(String key, bool b);

  Future<int> getInt(String key);
  void setInt(String key, int b);

  Future<String> getString(String key);
  void setString(String key, String b);

  void remove(String key);
}
