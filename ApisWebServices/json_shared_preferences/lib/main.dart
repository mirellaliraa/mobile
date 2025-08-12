import 'package:flutter/material.dart';
import 'tela_inicial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // pacote do dart (já vem instalado no projeto)

void main() {
  runApp(MaterialApp(home: ConfigPage()));
}

class ConfigPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConfigPageState();
  }
}

class _ConfigPageState extends State<ConfigPage> {
  // atributos
  bool temaEscuro = false;
  String nomeUsuario = ""; // texto vazio

  @override
  void initState() {
    super.initState();
    carregarPreferencias();
  }

  // método para carregar as informações do SharedPreferences
  void carregarPreferencias() async {
    final prefs =
        await SharedPreferences.getInstance(); // conexão com SharedPreferences
    String? jsonString = prefs.getString(
      "config",
    ); // estou recebendo os valores referentes a chave "config" do SP
    if (jsonString != null) {
      // ! = diferente , ? = pode ser nulo
      Map<String, dynamic> config = json.decode(jsonString);
      setState(() {
        temaEscuro = config["temaEscuro"] ?? false; // ?? operador para código null => atribui um valor caso o elemento seja nulo
        nomeUsuario = config["nome"] ?? "";
      });
    }
  }

  // construção da tela 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App de configurações",
      theme: temaEscuro ? ThemeData.dark() : ThemeData.light(), // operador ternário (if, else)
      home: TelaInicial(temaEscuro: temaEscuro, nomeUsuario: nomeUsuario,)
    );
  }
}
