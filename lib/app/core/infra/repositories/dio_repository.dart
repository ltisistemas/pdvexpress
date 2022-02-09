import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pdvexpress/app/core/domain/repositories/http_repository.dart';
import 'package:pdvexpress/app/core/domain/usecases/user_prefs.dart';
import 'package:path/path.dart';

class DioRepository implements HttpRepository {
  final UserPrefs userPref;

  DioRepository(this.userPref);

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://www.albuquerquehortifruti.com.br/api/spa/',
      followRedirects: false,
      validateStatus: (status) => (status != 500),
    ),
  );

  @override
  Future<void> setToken() async {
    final responseUser = await userPref.getUser();
    responseUser.fold((l) => null,
        (r) => dio.options.headers['Authorization'] = 'Bearer ${r.token}');
  }

  @override
  Future doDelete(String uri) async {
    await setToken();

    return dio.delete(uri);
  }

  @override
  Future doGet(String uri, {Map<String, dynamic>? queryParameters}) async {
    await setToken();

    if (queryParameters != null) dio.options.queryParameters = queryParameters;

    return dio.get(uri);
  }

  @override
  Future doMultipart(String uri, dynamic formData, List<File> files) async {
    await setToken();

    dio.options.headers["Content-Type"] = "multipart/form-data";

    FormData form = FormData.fromMap(formData);
    for (var file in files) {
      String filename = basename(file.path);

      MultipartFile multipartFile =
          MultipartFile.fromFileSync(file.path, filename: filename);

      MapEntry<String, MultipartFile> value =
          MapEntry('arquivos[]', multipartFile);
      form.files.add(value);
    }

    return dio.post(uri, data: form);
  }

  @override
  Future<dynamic> doPostJson(String uri, Map formData) async {
    try {
      await setToken();

      return dio.post(uri, data: formData);
    } catch (e) {
      return null;
    }
  }

  @override
  Future doPut(String uri, Map? formData) async {
    await setToken();

    return dio.put(uri, data: formData);
  }

  @override
  Future doPost(String uri, dynamic formData) async {
    await setToken();

    return dio.post(uri, data: formData);
  }

  @override
  Future doMultipartSingle(
      String uri, Map<String, dynamic>? formData, File file) async {
    await setToken();

    dio.options.headers["Content-Type"] = "multipart/form-data";

    FormData form = FormData.fromMap({});
    if (formData != null) {
      form = FormData.fromMap(formData);
    }

    String filename = basename(file.path);

    MultipartFile multipartFile =
        MultipartFile.fromFileSync(file.path, filename: filename);

    MapEntry<String, MultipartFile> value = MapEntry('avatar', multipartFile);
    form.files.add(value);

    return dio.post(uri, data: form);
  }
}
