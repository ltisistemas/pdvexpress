// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStoreBase, Store {
  final _$loadingAtom = Atom(name: '_LoginStoreBase.loading');

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

  final _$failureAtom = Atom(name: '_LoginStoreBase.failure');

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

  final _$cleanAsyncAction = AsyncAction('_LoginStoreBase.clean');

  @override
  Future<void> clean() {
    return _$cleanAsyncAction.run(() => super.clean());
  }

  final _$callAsyncAction = AsyncAction('_LoginStoreBase.call');

  @override
  Future<void> call() {
    return _$callAsyncAction.run(() => super.call());
  }

  final _$googleAsyncAction = AsyncAction('_LoginStoreBase.google');

  @override
  Future<void> google() {
    return _$googleAsyncAction.run(() => super.google());
  }

  final _$forgotAsyncAction = AsyncAction('_LoginStoreBase.forgot');

  @override
  Future<void> forgot(dynamic context) {
    return _$forgotAsyncAction.run(() => super.forgot(context));
  }

  final _$signUpAsyncAction = AsyncAction('_LoginStoreBase.signUp');

  @override
  Future<void> signUp(dynamic context) {
    return _$signUpAsyncAction.run(() => super.signUp(context));
  }

  @override
  String toString() {
    return '''
loading: ${loading},
failure: ${failure}
    ''';
  }
}
