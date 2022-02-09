import 'package:pdvexpress/app/core/domain/entities/produto.dart';

class ProdutoModel extends Produto {
  ProdutoModel(
    String? uuid,
    String? uuidUsuario,
    String nome,
    String? descricao,
    int? quantidade,
    String valor,
  ) : super(uuid, uuidUsuario, nome, descricao, quantidade, valor);

  factory ProdutoModel.fromJson(Map json) {
    final pUuid = json.containsKey('uuid') ? json['uuid'] : '';

    final qte = json['quantidade'] != '' ? int.parse(json['quantidade'])  : 0;
    final valor = json['valor'] != '' ? double.parse(json['valor']).toStringAsPrecision(2)  : '0.0';

    return ProdutoModel(
      pUuid,
      json['uuid_usuario'],
      json['nome'],
      json['descricao'],
      qte,
      valor,
    );
  }

  factory ProdutoModel.fromJsonRealTime(Map json) {
    final pUuid = json.containsKey('uuid') ? json['uuid'] : '';

    return ProdutoModel(
      pUuid,
      json['uuid_usuario'],
      json['nome'],
      json['descricao'],
      json['quantidade'],
      json['valor'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['uuid_usuario'] = uuidUsuario;
    data['nome'] = nome;
    data['descricao'] = descricao;
    data['quantidade'] = quantidade.toString();
    data['valor'] = valor;

    return data;
  }
}
