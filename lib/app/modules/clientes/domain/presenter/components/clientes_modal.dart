import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdvexpress/app/components/input_field.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';

class ClientesModal extends StatelessWidget {
  final BuildContext ctx;
  final Function onPressed;
  final TextEditingController controllerNome;
  final TextEditingController controllerTelefone;
  final TextEditingController controllerEmail;

  const ClientesModal({
    Key? key,
    required this.ctx,
    required this.onPressed,
    required this.controllerNome,
    required this.controllerTelefone,
    required this.controllerEmail,
  }) : super(key: key);

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
                    'Cadastrar novo cliente',
                    style: TextStyle(
                      color: darkThemeSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InputField(
                    labelText: 'Digite o nome',
                    controller: controllerNome,
                  ),
                  InputField(
                    labelText: 'Digite o telefone',
                    controller: controllerTelefone,
                  ),
                  InputField(
                    labelText: 'Digite o e-mail',
                    controller: controllerEmail,
                    type: TextInputType.number,
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
                          'Salvar produto',
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
