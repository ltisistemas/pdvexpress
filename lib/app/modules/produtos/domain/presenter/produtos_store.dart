import 'package:asuka/asuka.dart' as asuka;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pdvexpress/app/core/domain/entities/produto.dart';
import 'package:pdvexpress/app/core/domain/erros/error_order.dart';
import 'package:pdvexpress/app/core/domain/usecases/user_prefs.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';
import 'package:pdvexpress/app/core/infra/models/produto_model.dart';
import 'package:pdvexpress/app/modules/produtos/domain/presenter/components/produtos_modal.dart';
import 'package:pdvexpress/app/modules/produtos/domain/usecases/adicionar_produto.dart';
import 'package:pdvexpress/app/modules/produtos/domain/usecases/ativar_produto.dart';
import 'package:pdvexpress/app/modules/produtos/domain/usecases/atualizar_produto.dart';
import 'package:pdvexpress/app/modules/produtos/domain/usecases/excluir_produto.dart';

part 'produtos_store.g.dart';

class ProdutosStore = _ProdutosStoreBase with _$ProdutosStore;

abstract class _ProdutosStoreBase with Store {
  final useCase = Modular.get<CadastrarProdutoImpl>();
  final usecaseUpdate = Modular.get<AtualizarProdutoImpl>();
  final usecaseDestroy = Modular.get<ExcluirProdutoImpl>();
  final usecaseActivated = Modular.get<AtivarProdutoImpl>();
  final useCaseUser = Modular.get<UserPrefsImpl>();

  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerDescricao = TextEditingController();
  final TextEditingController _controllerQuantidade = TextEditingController();
  final TextEditingController _controllerValor = TextEditingController();

  BuildContext? currentCtx;

  Query<ProdutoModel> realTime = storeInstance
      .collection('produtos')
      .withConverter<ProdutoModel>(
        fromFirestore: (snapshot, _) =>
            ProdutoModel.fromJsonRealTime(snapshot.data()!),
        toFirestore: (produto, _) => produto.toJson(),
      )
      .where('uuid_usuario', isEqualTo: fireInstance.currentUser!.uid);

  @observable
  bool loading = false;

  @observable
  Option<ErrorOrder> failure = none();

  @action
  Future<void> call(BuildContext context) async {
    _controllerNome.clear();
    _controllerDescricao.clear();
    _controllerQuantidade.clear();
    _controllerValor.clear();

    showBottomSheet(
      context: context,
      builder: (_) {
        currentCtx = _;

        return ProdutosModal(
          ctx: _,
          onPressed: () => _addProduto(),
          controllerNome: _controllerNome,
          controllerDescricao: _controllerDescricao,
          controllerQuantidade: _controllerQuantidade,
          controllerValor: _controllerValor,
        );
      },
    );
  }

  Future<void> _addProduto() async {
    failure = none();

    final nome = _controllerNome.text;
    final descricao = _controllerDescricao.text;
    dynamic quantidade = _controllerQuantidade.text;
    dynamic valor = _controllerValor.text;

    if (nome.isEmpty || valor.isEmpty) {
      failure = optionOf(ErrorProdutoFieldsNotFound());
      return;
    }

    quantidade = quantidade.isEmpty ? quantidade : int.parse(quantidade);

    final response = await useCaseUser.getUser();
    response.fold(
      (failureResult) => failure = optionOf(ErrorOrderFailure()),
      (userLogged) {
        useCase({
          'uuid_usuario': userLogged.uuid,
          'nome': nome,
          'descricao': descricao,
          'quantidade': quantidade,
          'valor': valor,
        }).then((value) {
          Navigator.pop(currentCtx!);
        }).catchError((onError) {
          failure = optionOf(ErrorOrder());
        });
      },
    );
  }

  void feedback(BuildContext context, value) {
    String message = '';

    if (value is ErrorProdutoFieldsNotFound) {
      message = 'Nome e Valores precisam ser preenchidos';
    }

    edgeAlert(
      context,
      title: 'Erro',
      description: message,
      gravity: Gravity.top,
      backgroundColor: Colors.red,
      icon: Icons.error,
      duration: 5,
    );
  }

  @action
  Future<void> edit(context, Produto produto) async {
    _controllerNome.clear();
    _controllerDescricao.clear();
    _controllerQuantidade.clear();
    _controllerValor.clear();

    _controllerNome.text = produto.nome;
    _controllerDescricao.text = produto.descricao!;
    _controllerQuantidade.text = produto.quantidade.toString();
    _controllerValor.text = produto.valor;

    showBottomSheet(
      context: context,
      builder: (_) {
        currentCtx = _;

        return ProdutosModal(
          ctx: _,
          onPressed: () => _edit(produto),
          controllerNome: _controllerNome,
          controllerDescricao: _controllerDescricao,
          controllerQuantidade: _controllerQuantidade,
          controllerValor: _controllerValor,
        );
      },
    );
  }

  @action
  Future<void> _edit(Produto produto) async {
    failure = none();

    final nome = _controllerNome.text;
    final descricao = _controllerDescricao.text;
    dynamic quantidade = _controllerQuantidade.text;
    dynamic valor = _controllerValor.text;

    if (nome.isEmpty || valor.isEmpty) {
      failure = optionOf(ErrorProdutoFieldsNotFound());
      return;
    }

    // quantidade = quantidade.isEmpty ? quantidade : int.parse(quantidade);

    final response = await useCaseUser.getUser();
    response.fold(
      (failureResult) => failure = optionOf(ErrorOrderFailure()),
      (userLogged) {
        usecaseUpdate({
          'uuid': produto.uuid,
          'uuid_usuario': userLogged.uuid,
          'nome': nome,
          'descricao': descricao,
          'quantidade': quantidade,
          'valor': valor,
        }).then((value) {
          Navigator.pop(currentCtx!);
        }).catchError((onError) {
          failure = optionOf(ErrorOrder());
        });
      },
    );
  }

  @action
  Future<void> remove(Produto produto) async {
    asuka.showDialog(
      builder: (_) => AlertDialog(
        title: const Text('Exclusão de produto'),
        content: Text('Você irá excluir o produto: \n${produto.nome}?'),
        actions: [
          TextButton(
            onPressed: () => _remove(_, produto.uuid!),
            child: const Text(
              'Sim, quero excluir',
              style: TextStyle(color: dangerColor),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(_),
            child: const Text('Não'),
          ),
        ],
        elevation: 24.0,
      ),
    );
  }

  @action
  Future<void> _remove(ctx, String uid) async {
    failure = none();

    usecaseDestroy(uid).then((value) {
      Navigator.pop(ctx);
    }).catchError((onError) {
      failure = optionOf(ErrorOrder());
    });
  }

  @action
  Future<void> activated(Produto produto) async {
    asuka.showDialog(
      builder: (_) => AlertDialog(
        title: const Text('Ativação de produto'),
        content: Text('Você irá ativar o produto: \n${produto.nome}?'),
        actions: [
          TextButton(
            onPressed: () => _activated(_, produto.uuid!),
            child: const Text(
              'Sim, quero ativar',
              style:
                  TextStyle(color: successColor, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(_),
            child: const Text('Não'),
          ),
        ],
        elevation: 24.0,
      ),
    );
  }

  @action
  Future<void> _activated(ctx, String uid) async {
    failure = none();

    usecaseActivated(uid).then((value) {
      Navigator.pop(ctx);
    }).catchError((onError) {
      failure = optionOf(ErrorOrder());
    });
  }
}
