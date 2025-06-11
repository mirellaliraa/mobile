class Discos {
  final int? id;
  final String nome;
  final String artista;
  final String descricao;
  final int ano;

  Discos({
    this.id,
    required this.nome,
    required this.artista,
    required this.descricao,
    required this.ano
  });

  Map<String,dynamic> toMap(){
    return{
      "id": id,
      "nome": nome,
      "artista": artista,
      "descricao": descricao,
      "ano": ano
    };
  }

  factory Discos.fromMap(Map<String,dynamic> map){
    return Discos(
      id: map["id"] as int?,
      nome: map["nome"] as String, 
      artista: map ["artista"] as String, 
      descricao: ["descricao"] as String, 
      ano: ["ano"] as int,
      );
  }

}