import 'package:pdvexpress/app/core/domain/entities/cliente.dart';

class ClienteModel extends Cliente {
  ClienteModel(
    String? uuid,
    String? uuidUsuario,
    String nome,
    String? telefone,
    String? email,
    bool? active,
  ) : super(uuid, uuidUsuario, nome, telefone, email, active);

  factory ClienteModel.fromJson(Map json) {
    final pUuid = json.containsKey('uuid') ? json['uuid'] : '';

    return ClienteModel(
      pUuid,
      json['uuid_usuario'],
      json['nome'],
      json['telefone'],
      json['email'],
      json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['uuid_usuario'] = uuidUsuario;
    data['nome'] = nome;
    data['telefone'] = telefone;
    data['email'] = email;
    data['active'] = active;

    return data;
  }
}
