import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pdvexpress/app/core/domain/entities/produto.dart';
import 'package:pdvexpress/app/core/domain/usecases/user_prefs.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';
import 'package:pdvexpress/app/core/infra/models/produto_model.dart';
import 'package:pdvexpress/app/modules/home/domain/presenter/components/pagamento_modal.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  _HomeStoreBase() {
    call();
  }

  final useCaseUser = Modular.get<UserPrefsImpl>();
  BuildContext? currentCtx;
  ScrollController scrollController = ScrollController();

  // late TabController tabController;

  @observable
  bool isPaid = true;

  @observable
  ObservableList<Map<String, dynamic>> _produtos =
      ObservableList<Map<String, dynamic>>();

  @computed
  List<Map<String, dynamic>> get produtos => _produtos.toList();

  @computed
  bool get showButton =>
      _produtos.toList().where((element) => element['selected']).isNotEmpty;

  @computed
  int get count => _produtos.toList().length;

  final TextEditingController controllerValor = TextEditingController();
  final TextEditingController controllerQuantidade = TextEditingController();

  @action
  Future<void> add(BuildContext context) async {
    final response = await useCaseUser.getUser();
    response.fold((failureResult) => null, (userLogged) {
      showBottomSheet(
        context: context,
        builder: (_) {
          currentCtx = _;
          return PagamentoModal(
            ctx: _,
            user: userLogged,
            controllerValor: controllerValor,
            controllerQuantidade: controllerQuantidade,
            onPressed: () => {},
            onChangedPaid: (v) => _changePaid(v),
          );
        },
      );
    });
  }

  @action
  _changePaid(v) {
    isPaid = v;
  }

  @action
  Future<void> clear() async {
    _produtos.map((element) => element['selected'] = false);
  }

  Future<List<Map<String, dynamic>>> call() async {
    List<Map<String, dynamic>> list = [];
    _produtos.clear();

    final response = await useCaseUser.getUser();
    return response.fold((l) => list, (userLogged) {
      return storeInstance
          .collection('produtos')
          .where('uuid_usuario', isEqualTo: userLogged.uuid)
          .get()
          .then((value) {
        for (var produtoDoc in value.docs) {
          final json = produtoDoc.data();
          json['uuid'] = produtoDoc.id;

          final Produto produto = ProdutoModel.fromJsonRealTime(json);
          list.add(
              {'value': produto.uuid, 'text': produto.nome, 'selected': false});
          _produtos = _produtos
            ..add({
              'value': produto.uuid,
              'text': produto.nome,
              'selected': false,
              'controller': TextEditingController(),
              'focusNode': FocusNode(),
              'valor': produto.valor,
              'quantidade': 0.0,
            });
        }

        return list;
      });
    });
  }

  @action
  Future<void> selectItem(Map<String, dynamic> item, context) async {
    print('---> Click e solta');
    // print(item);

    // add(context);
  }

  @action
  Future<void> onLongPress(Map<String, dynamic> item, context) async {
    item['selected'] = !item['selected'];

    // _produtos.map((element) {
    //   if (element['value'] == item['value']) {
    //     element['selected'] = !element['selected'];
    //   }
    // });

    // final it = _produtos.firstWhere((element) => element['value'] == item['value'], orElse: () => { 'value': -1 });
    //
    // if (it['value'] != -1) {
    //   it['selected'] = !item['selected'];
    // }
  }
}
