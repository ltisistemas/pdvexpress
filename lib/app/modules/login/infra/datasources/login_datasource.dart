import 'package:pdvexpress/app/core/domain/entities/api_response.dart';

abstract class LoginDatasource {
  Future<ApiResponse> login(String login, String password);

  Future<ApiResponse> signUp(String nome, String email, String password);

  Future<ApiResponse> signOut();

  Future<ApiResponse> google();

  Future<ApiResponse> googleWeb();

  Future<ApiResponse> googleDevice();

  Future<ApiResponse> forgot(String email);
}