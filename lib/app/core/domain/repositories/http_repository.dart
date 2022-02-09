import 'dart:io';

abstract class HttpRepository {
  Future doGet(String uri, {Map<String, dynamic>? queryParameters});
  Future doPost(String uri, dynamic formData);
  Future doPostJson(String uri, Map formData);
  Future doMultipart(String uri, dynamic formData, List<File> files);
  Future doMultipartSingle(String uri, Map<String, dynamic>? formData, File file);
  Future doPut(String uri, Map formData);
  Future doDelete(String uri);
  Future<void> setToken();
}