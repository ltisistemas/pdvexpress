import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pdvexpress/app/core/domain/entities/produto.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';
import 'package:pdvexpress/app/core/infra/models/produto_model.dart';
import 'package:pdvexpress/app/modules/home/domain/presenter/components/float_button.dart';
import 'package:pdvexpress/app/modules/produtos/domain/presenter/produtos_store.dart';

class ProdutosHome extends StatefulWidget {
  const ProdutosHome({Key? key}) : super(key: key);

  @override
  _ProdutosHomeState createState() => _ProdutosHomeState();
}

class _ProdutosHomeState extends ModularState<ProdutosHome, ProdutosStore> {
  @override
  void initState() {
    reaction((_) => controller.failure, (_) {
      controller.failure.map((f) {
        controller.feedback(context, f);
      });
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Produtos'),
        centerTitle: true,
      ),
      floatingActionButton:
          AddPayButton(onPressed: () => controller.call(context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Container(
          color: darkThemeInputs,
          padding: const EdgeInsets.all(4),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Observer(
                builder: (context) {
                  if (controller.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return StreamBuilder<QuerySnapshot<ProdutoModel>>(
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

                      return ListView.builder(
                        itemBuilder: (_, __) {
                          final Produto produto = data.docs[__].data();
                          produto.uuid = data.docs[__].id;

                          return Container(
                            color: darkThemeBackground,
                            margin: const EdgeInsets.only(top: 8.0),
                            child: ListTile(
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () => controller.edit(),
                                    icon: const Icon(Icons.edit, color: lightColor),
                                  ),
                                  IconButton(
                                    onPressed: () => controller.remove(),
                                    icon: const Icon(Icons.delete, color: dangerColor),
                                  )
                                ],
                              ),
                              title: Text(
                                produto.nome,
                                style: const TextStyle(color: lightColor),
                              ),
                              subtitle: Container(
                                margin: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'R\$ ${double.parse(produto.valor).toStringAsPrecision(2)}',
                                  style: const TextStyle(color: lightColor),
                                ),
                              ),
                            ),
                          );
                        },
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
