class EmprestimoModel {
  final String? id;
  final String? usuarioId;
  final String? livroId;
  final DateTime dataEmprestimo;
  final DateTime dataDevolucao;
  final bool devolvido;

  EmprestimoModel({
    this.id,
    this.usuarioId,
    this.livroId,
    required this.dataEmprestimo,
    required this.dataDevolucao,
    required this.devolvido,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "usuarioId": usuarioId,
    "livroId": livroId,
    "dataEmprestimo": dataEmprestimo,
    "dataDevolucao": dataDevolucao,
    "devolvido": devolvido,
  };

  factory EmprestimoModel.fromJson(Map<String,dynamic> json) => EmprestimoModel(
    id: json["id"].toString(),
    usuarioId: json["usuarioId"].toString(),
    livroId: json["livroId"].toString(),
    dataEmprestimo: json["dataEmprestimo"], 
    dataDevolucao: json["dataDevolucao"], 
    devolvido: json["devolvido"] == true ? true : false);
}
