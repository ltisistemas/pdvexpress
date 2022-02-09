import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pdvexpress/app/core/domain/entities/api_response.dart';
import 'package:pdvexpress/app/core/domain/repositories/http_repository.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';
import 'package:pdvexpress/app/core/infra/models/api_response_model.dart';
import 'package:pdvexpress/app/core/infra/models/user_logged_model.dart';
import 'package:pdvexpress/app/modules/login/infra/datasources/login_datasource.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class LoginDatasourceImpl implements LoginDatasource {
  final HttpRepository http;

  LoginDatasourceImpl(this.http);

  @override
  Future<ApiResponse> forgot(String email) async {
    try {
      await fireInstance.sendPasswordResetEmail(email: email);

      return ApiResponseModel.ok(true, 'e-mail enviado com sucesso');
    } catch (e) {
      return ApiResponseModel.error('Erro ao efetuar o login');
    }
  }

  @override
  Future<ApiResponse> login(String login, String password) async {
    try {
      final response = await fireInstance.signInWithEmailAndPassword(
        email: login,
        password: password,
      );

      final userLogged = UserLoggedModel.fromUserCredential(response);

      return ApiResponseModel.ok(userLogged, 'Usuário realizado com sucesso');
    } catch (e) {
      return ApiResponseModel.error('Erro ao efetuar o login');
    }
  }
  @override
  Future<ApiResponse> google() async {
    if (kIsWeb) {
      // Id de cliente: 329936512773-316epdt31h8gaj0optqofvdroqu1q4cn.apps.googleusercontent.com
      // Chave secreta: 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

      return googleWeb();
    }

    return googleDevice();
  }

  @override
  Future<ApiResponse> googleDevice() async {
    try {
      final googleUser = await googleInstance.signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken
      );

      final UserCredential user = await fireInstance.signInWithCredential(credential);

      final userLogged = UserLoggedModel.fromUserCredential(user);

      return ApiResponseModel.ok(userLogged, 'Usuário realizado com sucesso');
    } catch (e) {
      return ApiResponseModel.error('Erro ao efetuar o login');
    }
  }

  @override
  Future<ApiResponse> googleWeb() async {
    await Firebase.initializeApp();

    GoogleAuthProvider authProvider = GoogleAuthProvider();

    try {
      final UserCredential userCredential = await fireInstance.signInWithPopup(authProvider);

      final userLogged = UserLoggedModel.fromUserCredential(userCredential);

      return ApiResponseModel.ok(userLogged, 'Usuário realizado com sucesso');
    } catch(e) {
      return ApiResponseModel.error('Erro ao efetuar o login');
    }
  }

  @override
  Future<ApiResponse> signUp(String nome, String email, String password) async {
    try {
      final UserCredential user = await fireInstance.createUserWithEmailAndPassword(email: email, password: password);

      await fireInstance.currentUser!.updateDisplayName(nome);

      final userLogged = UserLoggedModel.fromUserCredential(user);

      return ApiResponseModel.ok(userLogged, 'Usuário cadastrado com sucesso');
    } catch (e) {
      return ApiResponseModel.error('Erro ao efetuar o login');
    }
  }

  @override
  Future<ApiResponse> signOut() async {
    try {
      await fireInstance.signOut();

      return ApiResponseModel.ok(true, 'Usuário deslogado com sucesso');
    } catch (e) {
      return ApiResponseModel.error('Erro ao efetuar o login');
    }
  }
}
