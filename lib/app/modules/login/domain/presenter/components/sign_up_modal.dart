import 'package:flutter/material.dart';
import 'package:pdvexpress/app/components/input_field.dart';
import 'package:pdvexpress/app/components/password_field.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';

class SignUpModal extends StatelessWidget {
  final BuildContext ctx;
  final Function onPressed;
  final TextEditingController controllerNome;
  final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;

  const SignUpModal(
      {Key? key,
      required this.ctx,
      required this.onPressed,
      required this.controllerNome,
      required this.controllerEmail,
      required this.controllerPassword})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Material(
            child: Container(
              width: MediaQuery.of(ctx).size.width * 0.95,
              height: MediaQuery.of(ctx).size.height * 0.53,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 10,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tela de cadastro',
                    style: TextStyle(
                      color: darkThemeSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InputField(
                    labelText: 'Digite seu nome',
                    controller: controllerNome,
                  ),
                  InputField(
                    labelText: 'Digite seu E-mail',
                    controller: controllerEmail,
                  ),
                  PasswordField(
                    labelText: 'Digite sua senha',
                    controller: controllerPassword,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      primary: secondaryColor,
                    ),
                    onPressed: () => onPressed(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.check_circle, color: lightColor),
                        SizedBox(width: 8),
                        Text(
                          'Realizar cadastro',
                          style: TextStyle(color: lightColor),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ).copyWith(
                      side: MaterialStateProperty.resolveWith<BorderSide>(
                            (Set<MaterialState> states) {
                          return const BorderSide(color: dangerColor, width: 1);
                        },
                      ),
                    ).copyWith(
                      minimumSize: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> states) {
                          return const Size(double.infinity, 40);
                        },
                      ),
                    ),
                    onPressed: () => Navigator.pop(ctx),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.cancel, color: dangerColor),
                        SizedBox(width: 8),
                        Text(
                          'Fechar janela',
                          style: TextStyle(color: dangerColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
