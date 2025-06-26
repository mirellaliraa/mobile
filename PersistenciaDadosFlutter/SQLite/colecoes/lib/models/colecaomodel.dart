import 'package:intl/intl.dart';

class Colecao{
  final int? id;
  final String nome;
  final String descricao;
  final String tipo;

  Colecao({
    this.id,
    required this.nome,
    required this.descricao,
    required this.tipo,
  });

  Map<String, dynamic> toMap() => {
    "id":id,
    "nome":nome,
    "descricao":descricao,
    "tipo": tipo,
  };

  factory Colecao.fromMap(Map<String, dynamic> map) =>
  Colecao(
    id: map["id"] as int?,
    nome: map["nome"] as String, 
    descricao: map["descricao"] as String, 
    tipo: map["tipo"] as String,
    );

}