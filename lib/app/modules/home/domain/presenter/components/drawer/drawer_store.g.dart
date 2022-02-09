// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawer_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DrawerCtrl on _DrawerCtrlBase, Store {
  final _$loadingAtom = Atom(name: '_DrawerCtrlBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$failureAtom = Atom(name: '_DrawerCtrlBase.failure');

  @override
  Option<ErrorUser> get failure {
    _$failureAtom.reportRead();
    return super.failure;
  }

  @override
  set failure(Option<ErrorUser> value) {
    _$failureAtom.reportWrite(value, super.failure, () {
      super.failure = value;
    });
  }

  final _$userAtom = Atom(name: '_DrawerCtrlBase.user');

  @override
  UserLogged get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserLogged value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$callAsyncAction = AsyncAction('_DrawerCtrlBase.call');

  @override
  Future<void> call() {
    return _$callAsyncAction.run(() => super.call());
  }

  @override
  String toString() {
    return '''
loading: ${loading},
failure: ${failure},
user: ${user}
    ''';
  }
}
