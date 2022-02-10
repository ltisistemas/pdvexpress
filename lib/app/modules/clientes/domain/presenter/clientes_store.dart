import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pdvexpress/app/core/domain/entities/cliente.dart';
import 'package:pdvexpress/app/core/domain/erros/error_order.dart';
import 'package:pdvexpress/app/core/domain/usecases/user_prefs.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';
import 'package:pdvexpress/app/core/infra/models/cliente_model.dart';
import 'package:pdvexpress/app/modules/clientes/domain/presenter/components/clientes_modal.dart';
import 'package:pdvexpress/app/modules/clientes/domain/usecases/adicionar_cliente.dart';
import 'package:pdvexpress/app/modules/clientes/domain/usecases/ativar_cliente.dart';
import 'package:pdvexpress/app/modules/clientes/domain/usecases/atualizar_cliente.dart';
import 'package:pdvexpress/app/modules/clientes/domain/usecases/excluir_cliente.dart';
import 'package:asuka/asuka.dart' as asuka;

part 'clientes_store.g.dart';

class ClientesStore = _ClientesStoreBase with _$ClientesStore;

abstract class _ClientesStoreBase with Store {
  final useCase = Modular.get<CadastrarClienteImpl>();
  final useCaseUser = Modular.get<UserPrefsImpl>();

  final usecaseUpdate = Modular.get<AtualizarClienteImpl>();
  final usecaseDestroy = Modular.get<ExcluirClienteImpl>();
  final usecaseActivated = Modular.get<AtivarClienteImpl>();

  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerTelefone = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  BuildContext? currentCtx;

  Query<ClienteModel> realTime = storeInstance
      .collection('clientes')
      .withConverter<ClienteModel>(
        fromFirestore: (snapshot, _) => ClienteModel.fromJson(snapshot.data()!),
        toFirestore: (cliente, _) => cliente.toJson(),
      )
      .where('uuid_usuario', isEqualTo: fireInstance.currentUser!.uid);

  @observable
  bool loading = false;

  @observable
  Option<ErrorOrder> failure = none();

  @action
  Future<void> call(BuildContext context) async {
    _controllerNome.clear();
    _controllerTelefone.clear();
    _controllerEmail.clear();

    showBottomSheet(
      context: context,
      builder: (_) {
        currentCtx = _;

        return ClientesModal(
          ctx: _,
          onPressed: () => _addCliente(),
          controllerNome: _controllerNome,
          controllerTelefone: _controllerTelefone,
          controllerEmail: _controllerEmail,
        );
      },
    );
  }

  Future<void> _addCliente() async {
    final response = await useCaseUser.getUser();
    response.fold(
      (failureResult) => failure = optionOf(ErrorOrderFailure()),
      (userLogged) {
        useCase({
          'uuid_usuario': userLogged.uuid,
          'nome': _controllerNome.text,
          'telefone': _controllerTelefone.text,
          'email': _controllerEmail.text,
        }).then((value) {
          Navigator.pop(currentCtx!);
        }).catchError((onError) {
          failure = optionOf(ErrorOrder());
        });
      },
    );
  }

  @action
  Future<void> edit(context, Cliente cliente) async {
    _controllerNome.clear();
    _controllerTelefone.clear();
    _controllerEmail.clear();

    _controllerNome.text = cliente.nome;
    _controllerTelefone.text = cliente.telefone!;
    _controllerEmail.text = cliente.email!;

    showBottomSheet(
      context: context,
      builder: (_) {
        currentCtx = _;

        return ClientesModal(
          ctx: _,
          onPressed: () => _edit(cliente),
          controllerNome: _controllerNome,
          controllerTelefone: _controllerTelefone,
          controllerEmail: _controllerEmail,
        );
      },
    );
  }

  @action
  Future<void> _edit(Cliente cliente) async {
    failure = none();
    usecaseUpdate({
      'nome': _controllerNome.text,
      'telefone': _controllerTelefone.text,
      'email': _controllerEmail.text,
    }).then((value) {
      Navigator.pop(currentCtx!);
    }).catchError((onError) {
      failure = optionOf(ErrorOrder());
    });
  }

  @action
  Future<void> remove(Cliente cliente) async {
    asuka.showDialog(
      builder: (_) => AlertDialog(
        title: const Text('Desativação de cliente'),
        content: Text('Você irá desativar o cliente: \n${cliente.nome}?'),
        actions: [
          TextButton(
            onPressed: () => _remove(_, cliente.uuid!),
            child: const Text(
              'Sim, quero desativar',
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
  Future<void> activated(Cliente cliente) async {
    asuka.showDialog(
      builder: (_) => AlertDialog(
        title: const Text('Ativação de cliente'),
        content: Text('Você irá ativar o cliente: \n${cliente.nome}?'),
        actions: [
          TextButton(
            onPressed: () => _activated(_, cliente.uuid!),
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
