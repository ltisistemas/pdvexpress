import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:pdvexpress/app/components/button_cta.dart';
import 'package:pdvexpress/app/components/input_field.dart';
import 'package:pdvexpress/app/components/password_field.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';
import 'package:pdvexpress/app/modules/login/domain/presenter/login_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginStore> {
  @override
  void initState() {
    reaction((_) => controller.failure, (_) {
      controller.failure.map((f) => controller.feedback(context, f));
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Container(
            color: darkThemeBackgroundMaterial,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),
                      const Text(
                        'Bem vindo de volta',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: darkThemeTitle,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(56),
                        child: Center(
                            child: Text(
                          'Digite abaixo seu e-mail e sua senha para continuar no aplicativo',
                          style: TextStyle(
                            fontSize: 16,
                            color: darkThemeSubtitle,
                          ),
                        )),
                      ),
                      const SizedBox(height: 24),
                      // const LogoBrand(width: 0.4),
                      InputField(
                        labelText: 'Usuário',
                        type: TextInputType.text,
                        obscureText: false,
                        onChanged: (t) => {},
                        controller: controller.login,
                      ),
                      PasswordField(
                        labelText: 'Senha',
                        onChanged: (t) => {},
                        controller: controller.password,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(top: 16),
                        padding: const EdgeInsets.only(right: 16),
                        child: InkWell(
                          onTap: () => controller.forgot(context),
                          child: const Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(
                              fontSize: 14,
                              color: darkThemeSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(top: 16),
                        padding: const EdgeInsets.only(right: 16),
                        child: InkWell(
                          onTap: () => controller.signUp(context),
                          child: const Text(
                            'Não tem cadastro? Clique aqui',
                            style: TextStyle(
                              fontSize: 14,
                              color: darkThemeTitle,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      ButtonCta(
                        icon: Icons.login,
                        text: 'Efetuar Login',
                        onPressed: () => controller.call(),
                        inProgress: controller.loading,
                      ),
                      Container(height: 32),
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        child: IconButton(
                          onPressed: () => controller.google(),
                          icon: const FaIcon(
                            FontAwesomeIcons.google,
                            size: 18,
                            color: dangerColor,
                          ),
                        ),
                      ),
                      Container(margin: const EdgeInsets.only(bottom: 16)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
