import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pdvexpress/app/core/domain/entities/cliente.dart';
import 'package:pdvexpress/app/core/domain/entities/produto.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';
import 'package:pdvexpress/app/core/infra/models/cliente_model.dart';
import 'package:pdvexpress/app/modules/clientes/domain/presenter/clientes_store.dart';
import 'package:pdvexpress/app/modules/home/domain/presenter/components/float_button.dart';

class ClientesHome extends StatefulWidget {
  const ClientesHome({Key? key}) : super(key: key);

  @override
  _ClientesHomeState createState() => _ClientesHomeState();
}

class _ClientesHomeState extends ModularState<ClientesHome, ClientesStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Clientes'),
        centerTitle: true,
      ),
      floatingActionButton:
          AddPayButton(onPressed: () => controller.call(context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Container(
          color: darkThemeBackground,
          padding: const EdgeInsets.all(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Observer(
                builder: (context) {
                  if (controller.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return StreamBuilder<QuerySnapshot<ClienteModel>>(
                    stream: controller.realTime.snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final data = snapshot.requireData;

                      return ListView.separated(
                        itemBuilder: (_, __) {
                          final Cliente cliente = data.docs[__].data();
                          cliente.uuid = data.docs[__].id;

                          return Container(
                            color:
                                cliente.active! ? darkThemeInputs : dangerColor,
                            margin: const EdgeInsets.only(top: 8.0),
                            child: ListTile(
                              title: Text(
                                cliente.nome,
                                style: const TextStyle(color: lightColor),
                              ),
                              subtitle: Text(
                                'Telefone: ${cliente.telefone}',
                                style: const TextStyle(color: lightColor),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        controller.edit(context, cliente),
                                    icon: const Icon(Icons.edit,
                                        color: lightColor),
                                  ),
                                  !!cliente.active!
                                      ? IconButton(
                                          onPressed: () =>
                                              controller.remove(cliente),
                                          icon: const Icon(Icons.delete,
                                              color: lightColor),
                                        )
                                      : Container(),
                                  !cliente.active!
                                      ? IconButton(
                                          onPressed: () =>
                                              controller.activated(cliente),
                                          icon: const Icon(Icons.check_circle,
                                              color: lightColor),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Container(
                          height: 0,
                          color: darkThemeSubtitle,
                        ),
                        itemCount: data.size,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
