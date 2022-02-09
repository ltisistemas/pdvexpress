import 'package:dartz/dartz.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:pdvexpress/app/core/domain/erros/error_user.dart';
import 'package:pdvexpress/app/core/domain/usecases/user_prefs.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';
import 'package:pdvexpress/app/modules/login/domain/presenter/components/forgot_modal.dart';
import 'package:pdvexpress/app/modules/login/domain/presenter/components/sign_up_modal.dart';
import 'package:pdvexpress/app/modules/login/domain/usecases/cadastrar_usuario.dart';
import 'package:pdvexpress/app/modules/login/domain/usecases/deslogar.dart';
import 'package:pdvexpress/app/modules/login/domain/usecases/esqueci_minha_senha.dart';
import 'package:pdvexpress/app/modules/login/domain/usecases/google.dart';
import 'package:pdvexpress/app/modules/login/domain/usecases/login.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final useCaseUser = Modular.get<UserPrefsImpl>();
  final Login useCase = Modular.get<LoginImpl>();
  final CadastrarUsuario useCaseSignUp = Modular.get<CadastrarUsuarioImpl>();
  final Login useCaseGoogle = Modular.get<GoogleImpl>();
  final usecaseLogout = Modular.get<DeslogarImpl>();
  final usecaseForgot = Modular.get<EsqueciMinhaSenhaImpl>();

  _LoginStoreBase() {
    clean();
  }

  @action
  Future<void> clean() async {
    useCaseUser.deleteUser();

    usecaseLogout();
  }

  void feedback(context, value) async {
    String message = '';

    if (value is ErrorUser) {
      message = 'Erro no login';
    }
    if (value is ErrorUserLoginFailure) {
      message = 'Erro ao realizar o login';
    }
    if (value is ErrorUserLoginAndPasswordNotFound) {
      message = 'Preencha todos os campos';
    }
    if (value is ErrorUserNotFound) {
      message = 'Usuário não encontrado';
    }

    edgeAlert(
      context,
      title: 'Erro',
      description: message,
      gravity: Gravity.top,
      backgroundColor: dangerColor,
      icon: Icons.error,
      duration: 5,
    );
  }

  final TextEditingController login = TextEditingController();
  final TextEditingController password = TextEditingController();

  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  BuildContext? currentCtx;

  @observable
  bool loading = false;

  @observable
  Option<ErrorUser> failure = none();

  @action
  Future<void> call() async {
    loading = true;
    failure = none();

    final response = await useCase.call(login.text, password.text);
    response.fold((failureResult) {
      failure = optionOf(failureResult);
      loading = false;
    }, (r) {
      loading = false;
      Modular.to.pushReplacementNamed('/');
    });
  }

  @action
  Future<void> google() async {
    loading = true;
    failure = none();

    final response = await useCaseGoogle('', '');
    response.fold((failureResult) {
      failure = optionOf(failureResult);
      loading = false;
    }, (r) {
      loading = false;
      Modular.to.pushReplacementNamed('/');
    });
  }
  @action
  Future<void> forgot(context) async {
    _controllerNome.clear();
    _controllerPassword.clear();
    _controllerEmail.clear();

    showBottomSheet(
      context: context,
      builder: (_) {
        currentCtx = _;

        return ForgotModal(
          ctx: _,
          onPressed: () => _forgot(),
          controllerEmail: _controllerEmail,
        );
      },
    );
  }

  @action
  Future<void> signUp(context) async {
    _controllerNome.clear();
    _controllerPassword.clear();
    _controllerEmail.clear();

    showBottomSheet(
      context: context,
      builder: (_) {
        currentCtx = _;

        return SignUpModal(
          ctx: _,
          onPressed: () => _addUser(),
          controllerNome: _controllerNome,
          controllerEmail: _controllerEmail,
          controllerPassword: _controllerPassword,
        );
      },
    );
  }

  Future<void> _addUser() async {
    failure = none();

    final response = await useCaseSignUp(_controllerNome.text, _controllerEmail.text, _controllerPassword.text);
    response.fold((failureResult) {
      failure = optionOf(failureResult);
      loading = false;
    }, (r) {
      loading = false;
      Navigator.pop(currentCtx!);
      Modular.to.pushReplacementNamed('/');
    });
  }

  Future<void> _forgot() async {
    failure = none();

    final response = await usecaseForgot(_controllerEmail.text);
    response.fold((failureResult) {
      failure = optionOf(failureResult);
      loading = false;
    }, (r) {
      loading = false;
      Navigator.pop(currentCtx!);
      Modular.to.pushReplacementNamed('/');
    });
  }
}
