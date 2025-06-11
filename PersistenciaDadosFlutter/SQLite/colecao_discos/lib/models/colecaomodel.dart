import 'package:intl/intl.dart';

class Colecao{
  final int? id;
  final int discoId;
  final String dono;
  final DateTime dataAdicao;

  Colecao({
    this.id,
    required this.discoId,
    required this.dono,
    required this.dataAdicao,
  });

  Map<String, dynamic> toMap() => {
    "id":id,
    "disco_id":discoId,
    "dono":dono,
    "data_adicao": dataAdicao.toIso8601String(),
  };

  factory Colecao.fromMap(Map<String, dynamic> map) =>
  Colecao(
    discoId: map["discoId"] as int, 
    dono: map["dono"] as String, 
    dataAdicao: map["dataAdicao"] as DateTime,
    );

    String get dataHoraLocal {
      final local = DateFormat("dd/mm/yyyy HH:mm");
      return local.format(dataAdicao);
    }
}