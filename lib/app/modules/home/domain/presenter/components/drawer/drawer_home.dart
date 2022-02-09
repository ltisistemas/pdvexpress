import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';
import 'package:pdvexpress/app/modules/home/domain/presenter/components/drawer/drawer_store.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({Key? key}) : super(key: key);

  @override
  _DrawerHomeState createState() => _DrawerHomeState();
}

class _DrawerHomeState extends ModularState<DrawerHome, DrawerCtrl> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            Observer(
              builder: (_) {
                if (controller.user.uuid == '' && controller.user.avatarUrl == '') {
                  return Container();
                }

                return UserAccountsDrawerHeader(
                  accountName: Text(
                    controller.userLogged!.displayName!,
                    style: const TextStyle(color: lightColor),
                  ),
                  accountEmail: Text(
                    controller.userLogged!.email!,
                    style: const TextStyle(color: lightColor),
                  ),
                  currentAccountPicture: controller.userLogged!.photoURL != null ? CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(controller.userLogged!.photoURL!),
                  ) : Container(),
                  // currentAccountPicture: CircleAvatar(
                  //   backgroundImage: NetworkImage(controller.user.avatarUrl!),
                  // ),
                  onDetailsPressed: () {},
                );
              },
            ),
            ListTile(
              onTap: () async {
                // await Modular.get<UserPrefsImpl>().deleteUser();
                Modular.to.pushReplacementNamed('/');
              },
              title: const Text('PDV'),
              subtitle: const Text('Tela principal / Minhas vendas'),
              leading: const Icon(
                Icons.shopping_cart,
                color: darkThemeBackground,
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () async {
                // await Modular.get<UserPrefsImpl>().deleteUser();
                Modular.to.pushNamedAndRemoveUntil('/produtos', (_) => false);
              },
              title: const Text('Produtos'),
              subtitle: const Text('Cadastro / Visualização'),
              leading: const Icon(
                Icons.folder,
                color: darkThemeBackground,
              ),
            ),
            ListTile(
              onTap: () async {
                // await Modular.get<UserPrefsImpl>().deleteUser();
                Modular.to.pushNamedAndRemoveUntil('/clientes', (_) => false);
              },
              title: const Text('Clientes'),
              subtitle: const Text('Cadastro / Visualização'),
              leading: const Icon(
                Icons.folder,
                color: darkThemeBackground,
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: dangerColor,
              ),
              title: const Text(
                'Sair da conta',
                style: TextStyle(color: dangerColor),
              ),
              subtitle: const Text('Realizar logoff'),
              trailing: const Icon(
                Icons.arrow_forward,
                color: dangerColor,
              ),
              onTap: () async {
                // await Modular.get<UserPrefsImpl>().deleteUser();
                //
                Modular.to.pushNamedAndRemoveUntil('/login', (_) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
