import 'package:flutter/material.dart';
import 'package:pdvexpress/app/components/drop_down_field.dart';
import 'package:pdvexpress/app/components/input_field.dart';
import 'package:pdvexpress/app/core/domain/entities/cliente.dart';
import 'package:pdvexpress/app/core/domain/entities/produto.dart';
import 'package:pdvexpress/app/core/domain/entities/user_logged.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';
import 'package:pdvexpress/app/core/infra/models/cliente_model.dart';

class PagamentoModal extends StatefulWidget {
  final BuildContext ctx;
  final UserLogged user;
  final TextEditingController controllerValor;
  final TextEditingController controllerQuantidade;
  final Function onPressed;
  final Function(bool) onChangedPaid;

  const PagamentoModal({
    Key? key,
    required this.ctx,
    required this.user,
    required this.controllerValor,
    required this.controllerQuantidade,
    required this.onPressed,
    required this.onChangedPaid,
  }) : super(key: key);

  @override
  State<PagamentoModal> createState() => _PagamentoModalState();
}

class _PagamentoModalState extends State<PagamentoModal> {
  List<Map<String, dynamic>> clientes = [];
  List<Produto> produtos = [];

  String selectedCliente = '';

  String selectedProduto = '';

  bool paid = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Material(
            child: Container(
              width: MediaQuery.of(widget.ctx).size.width * 0.95,
              height: MediaQuery.of(widget.ctx).size.height,
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
                    'Nova venda',
                    style: TextStyle(
                      color: darkThemeSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: getClientes(),
                    builder: (_, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasData) {
                        List<Map<String, dynamic>> itens = [];

                        for (var item in snapshot.data!) {
                          itens.add(item);
                        }

                        return DropDownField(
                          labelText: 'Clientes',
                          selected: selectedCliente,
                          items: itens,
                          onChanged: (c) => {},
                        );
                      }

                      return Container();
                    },
                  ),
                  InputField(
                    labelText: 'Digite o valor',
                    controller: widget.controllerValor,
                    type: TextInputType.number,
                  ),
                  InputField(
                    labelText: 'Digite a quantidade',
                    controller: widget.controllerQuantidade,
                    type: TextInputType.number,
                  ),
                  SwitchListTile(
                    value: paid,
                    onChanged: (v) {
                      setState(() {
                        paid = v;
                        widget.onChangedPaid(v);
                      });
                    },
                    activeColor: successColor,
                    inactiveTrackColor: dangerColor,
                    activeTrackColor: successColorAcent,
                    inactiveThumbColor: dangerColorAcent,
                    title: const Center(child: Text('Este valor já foi pago?')),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      primary: secondaryColor,
                    ),
                    onPressed: () => widget.onPressed(),
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
                    onPressed: () => Navigator.pop(widget.ctx),
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

  Future<List<Map<String, dynamic>>> getClientes() async {
    return storeInstance
        .collection('clientes')
        .where('uuid_usuario', isEqualTo: widget.user.uuid)
        .where('active', isEqualTo: true)
        .get()
        .then(
      (value) {
        List<Map<String, dynamic>> list = [
          {'value': '', 'text': 'Selecione um cliente'}
        ];

        for (var clienteDoc in value.docs) {
          final json = clienteDoc.data();
          json['uuid'] = clienteDoc.id;

          final Cliente cliente = ClienteModel.fromJson(json);
          list.add({'value': cliente.uuid, 'text': cliente.nome});
        }

        return list;
      },
    );
  }
}
