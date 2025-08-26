class UsuarioModel {
  final String? id;
  final String nome;
  final String email;

  UsuarioModel({
    this.id,
    required this.nome,
    required this.email
  });

  // métodos
  // to json
  Map<String,dynamic> toJson() => {
    "id":id,
    "nome":nome,
    "email":email
  };

  // from json
  factory UsuarioModel.fromJson(Map<String,dynamic> json) => UsuarioModel(
    id: json["id"].toString(),
    nome: json["nome"].toString(), 
    email: json["email"].toString());
}


