class Produto {
  String? uuid;
  String? uuidUsuario;
  final String nome;
  final String? descricao;
  final int? quantidade;
  final String valor;

  Produto(
    this.uuid,
    this.uuidUsuario,
    this.nome,
    this.descricao,
    this.quantidade,
    this.valor,
  );
}
