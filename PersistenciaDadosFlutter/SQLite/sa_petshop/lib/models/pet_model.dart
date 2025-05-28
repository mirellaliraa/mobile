class Pet {
  // atributos ->
  final int? id; // pode ser nulo
  final String nome;
  final String raca;
  final String nomeDono;
  final String telefone;

  // final = pode mudar apenas uma vez, diferente de const q nunca muda

  // métodos
  Pet({
    this.id,
    required this.nome,
    required this.raca,
    required this.nomeDono,
    required this.telefone
  });

  // métodos de conversão de obj <=> bd
  // toMap: obj => BD
  Map<String,dynamic> toMap() {
    return{
      "id": id,
      "nome": nome,
      "raca": raca,
      "nome_dono": nomeDono,
      "telefone": telefone
    };
  }

  // fromMap: BD => Obj
  factory Pet.fromMap(Map<String,dynamic> map){
    return Pet(
      id: map["id"] as int, // cast
      nome: map["nome"] as String, 
      raca: map["raca"] as String,
      nomeDono: map["nomeDono"] as String, 
      telefone: map ["telefone"] as String
      );
  }
}