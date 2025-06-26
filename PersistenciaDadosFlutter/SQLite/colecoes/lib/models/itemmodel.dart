class Item {
  final int? id;
  final String nome;
  final String descricao;
  final double valor;
  final int ano;

  Item({
    this.id,
    required this.nome,
    required this.descricao,
    required this.valor,
    required this.ano
  });

  Map<String,dynamic> toMap(){
    return{
      "id": id,
      "nome": nome,
      "descricao": descricao,
      "valor": valor,
      "ano": ano
    };
  }
  
  factory Item.fromMap(Map<String,dynamic> map){
    return Item(
      id: map["id"] as int?,
      nome: map["nome"] as String, 
      descricao: map ["descricao"] as String, 
      valor: map["valor"] as double, 
      ano: map["ano"] as int,
    );
  }
}