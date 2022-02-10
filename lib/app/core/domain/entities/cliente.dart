class Cliente {
  String? uuid;
  String? uuidUsuario;
  final String nome;
  final String? telefone;
  final String? email;
  final bool? active;

  Cliente(
    this.uuid,
    this.uuidUsuario,
    this.nome,
    this.telefone,
    this.email,
    this.active,
  );
}
