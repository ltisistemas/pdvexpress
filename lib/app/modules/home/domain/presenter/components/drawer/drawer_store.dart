import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:dartz/dartz.dart';
import 'package:pdvexpress/app/core/domain/erros/error_user.dart';
import 'package:pdvexpress/app/core/domain/usecases/user_prefs.dart';
import 'package:pdvexpress/app/core/domain/entities/user_logged.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';

part 'drawer_store.g.dart';

class DrawerCtrl = _DrawerCtrlBase with _$DrawerCtrl;

abstract class _DrawerCtrlBase with Store {
  _DrawerCtrlBase() {
    call();
  }

  final userLogged = fireInstance.currentUser;

  final useCase = Modular.get<UserPrefsImpl>();

  @observable
  bool loading = false;

  @observable
  Option<ErrorUser> failure = none();

  @observable
  UserLogged user = UserLogged('', '', '', '', '');

  @action
  Future<void> call() async {
    failure = none();

    final response = await useCase.getUser();
    response.fold(
          (failureResult) => failure = optionOf(failureResult),
          (userLogged) {
            print(userLogged.avatarUrl);
            user = userLogged;
          },
    );
  }
}