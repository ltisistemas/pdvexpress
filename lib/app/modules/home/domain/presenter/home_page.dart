import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pdvexpress/app/components/input_field.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';
import 'package:pdvexpress/app/modules/home/domain/presenter/components/drawer/drawer_home.dart';
import 'package:pdvexpress/app/modules/home/domain/presenter/components/float_button.dart';
import 'package:pdvexpress/app/modules/home/domain/presenter/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    var maxWidth = 500.0;
    var width = MediaQuery.of(context).size.width;
    var columns = (width ~/ maxWidth) + 1;
    var columnWidth = width / columns;
    var aspectRatio = columnWidth / 136;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PDV Express'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () => controller.call(), icon: const Icon(Icons.refresh)),
            controller.showButton ? IconButton(onPressed: () => setState(() => controller.clear()), icon: const Icon(Icons.cancel)) : Container(),
          ],
          bottom: const TabBar(
            indicatorColor: darkThemeCta,
            tabs: [
              Tab(
                icon: Icon(Icons.shopping_cart),
                text: 'Vender',
              ),
              Tab(
                icon: Icon(Icons.list_sharp),
                text: 'Minhas vendas',
              )
            ],
          ),
        ),
        drawer: const DrawerHome(),
        floatingActionButton: controller.showButton
            ? AddPayButton(onPressed: () => controller.add(context))
            : Container(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: TabBarView(
          children: [
            SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  color: darkThemeInputs,
                  padding: const EdgeInsets.all(16),
                  child: Observer(
                    builder: (_) {
                      if (controller.count <= 0) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.separated(
                          shrinkWrap: true,
                          controller: controller.scrollController,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (_, __) => Container(
                            color: controller.produtos[__]['selected']
                                ? darkThemeSecondary
                                : darkThemeCta,
                            child: CheckboxListTile(
                              activeColor: darkThemeCta,
                              controlAffinity: ListTileControlAffinity.leading,
                              value: controller.produtos[__]['selected'],
                              onChanged: (v) => {
                                setState(
                                  () {
                                    controller.produtos[__]['selected'] = v;
                                    if (v == false) {
                                      controller.produtos[__]['controller']
                                          .clear();
                                    } else {
                                      controller.produtos[__]['focusNode']
                                          .requestFocus();
                                    }
                                  },
                                ),
                              },
                              subtitle: Container(
                                margin: const EdgeInsets.only(top: 8),
                                child: Text('R\$ ${controller.produtos[__]['valor']}', style: const TextStyle(color: darkColor),),
                              ),
                              secondary: SizedBox(
                                width: 100,
                                child: InputField(
                                  controller: controller.produtos[__]
                                      ['controller'],
                                  focusNode: controller.produtos[__]['focusNode'],
                                  labelText: 'Qte.',
                                  type: TextInputType.number,
                                ),
                              ),
                              title: Text(
                                controller.produtos[__]['text'],
                                style: const TextStyle(color: lightColor),
                              ),
                            ),
                          ),
                          separatorBuilder: (_, __) =>
                              Container(color: darkThemeInputs, height: 4),
                          itemCount: controller.count,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Container(
                color: darkThemeInputs,
                padding: const EdgeInsets.all(16),
                child: Container(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
