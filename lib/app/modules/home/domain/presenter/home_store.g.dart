// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStoreBase, Store {
  Computed<List<Map<String, dynamic>>>? _$produtosComputed;

  @override
  List<Map<String, dynamic>> get produtos => (_$produtosComputed ??=
          Computed<List<Map<String, dynamic>>>(() => super.produtos,
              name: '_HomeStoreBase.produtos'))
      .value;
  Computed<bool>? _$showButtonComputed;

  @override
  bool get showButton =>
      (_$showButtonComputed ??= Computed<bool>(() => super.showButton,
              name: '_HomeStoreBase.showButton'))
          .value;
  Computed<int>? _$countComputed;

  @override
  int get count => (_$countComputed ??=
          Computed<int>(() => super.count, name: '_HomeStoreBase.count'))
      .value;

  final _$isPaidAtom = Atom(name: '_HomeStoreBase.isPaid');

  @override
  bool get isPaid {
    _$isPaidAtom.reportRead();
    return super.isPaid;
  }

  @override
  set isPaid(bool value) {
    _$isPaidAtom.reportWrite(value, super.isPaid, () {
      super.isPaid = value;
    });
  }

  final _$_produtosAtom = Atom(name: '_HomeStoreBase._produtos');

  @override
  ObservableList<Map<String, dynamic>> get _produtos {
    _$_produtosAtom.reportRead();
    return super._produtos;
  }

  @override
  set _produtos(ObservableList<Map<String, dynamic>> value) {
    _$_produtosAtom.reportWrite(value, super._produtos, () {
      super._produtos = value;
    });
  }

  final _$addAsyncAction = AsyncAction('_HomeStoreBase.add');

  @override
  Future<void> add(BuildContext context) {
    return _$addAsyncAction.run(() => super.add(context));
  }

  final _$clearAsyncAction = AsyncAction('_HomeStoreBase.clear');

  @override
  Future<void> clear() {
    return _$clearAsyncAction.run(() => super.clear());
  }

  final _$selectItemAsyncAction = AsyncAction('_HomeStoreBase.selectItem');

  @override
  Future<void> selectItem(Map<String, dynamic> item, dynamic context) {
    return _$selectItemAsyncAction.run(() => super.selectItem(item, context));
  }

  final _$onLongPressAsyncAction = AsyncAction('_HomeStoreBase.onLongPress');

  @override
  Future<void> onLongPress(Map<String, dynamic> item, dynamic context) {
    return _$onLongPressAsyncAction.run(() => super.onLongPress(item, context));
  }

  final _$_HomeStoreBaseActionController =
      ActionController(name: '_HomeStoreBase');

  @override
  dynamic _changePaid(dynamic v) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase._changePaid');
    try {
      return super._changePaid(v);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isPaid: ${isPaid},
produtos: ${produtos},
showButton: ${showButton},
count: ${count}
    ''';
  }
}
