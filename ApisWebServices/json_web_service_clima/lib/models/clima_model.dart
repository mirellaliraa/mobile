class ClimaModel {
  // atributos
  final String cidade;
  final double temperatura;
  final String descricao;

  // constructor
  ClimaModel({
    required this.cidade,
    required this.temperatura,
    required this.descricao,
  });

  // factory -> porque não vou escrever nada na API (só receber informações)
  factory ClimaModel.fromJson(Map<String, dynamic> json) {
    return ClimaModel(
      cidade: json["name"],
      temperatura: json["main"]["temp"].toDouble(),
      descricao: json["weather"][0]["description"],
    );
  }
}
