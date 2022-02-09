// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produtos_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProdutosStore on _ProdutosStoreBase, Store {
  final _$loadingAtom = Atom(name: '_ProdutosStoreBase.loading');

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

  final _$failureAtom = Atom(name: '_ProdutosStoreBase.failure');

  @override
  Option<ErrorOrder> get failure {
    _$failureAtom.reportRead();
    return super.failure;
  }

  @override
  set failure(Option<ErrorOrder> value) {
    _$failureAtom.reportWrite(value, super.failure, () {
      super.failure = value;
    });
  }

  final _$callAsyncAction = AsyncAction('_ProdutosStoreBase.call');

  @override
  Future<void> call(BuildContext context) {
    return _$callAsyncAction.run(() => super.call(context));
  }

  final _$editAsyncAction = AsyncAction('_ProdutosStoreBase.edit');

  @override
  Future<void> edit() {
    return _$editAsyncAction.run(() => super.edit());
  }

  final _$removeAsyncAction = AsyncAction('_ProdutosStoreBase.remove');

  @override
  Future<void> remove() {
    return _$removeAsyncAction.run(() => super.remove());
  }

  @override
  String toString() {
    return '''
loading: ${loading},
failure: ${failure}
    ''';
  }
}
