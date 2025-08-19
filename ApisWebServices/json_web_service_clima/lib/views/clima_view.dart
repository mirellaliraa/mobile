import 'package:flutter/material.dart';
import 'package:json_web_service_clima/controllers/clima_controller.dart';
import 'package:json_web_service_clima/models/clima_model.dart';

class ClimaView extends StatefulWidget {
  const ClimaView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ClimaViewState();
  }
}

class _ClimaViewState extends State<ClimaView> {
  // atributos
  final TextEditingController _cidadeController = TextEditingController();
  ClimaModel? _clima;
  String? _erro;
  final ClimaController _climaController = ClimaController();

  // método para buscar clima da cidade
  void _buscar() async {
    try {
      final cidade = _cidadeController.text.trim();
      final resultado = await _climaController.buscarClima(cidade);
      setState(() {
        if (resultado != null) {
          _clima = resultado;
          _erro = null;
        } else {
          _clima = null;
          _erro = "Cidade não encontrada";
        }
      });
    } catch (e) {
      print("Erro ao buscar cidade: $e");
    }
  }

  // build da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Clima em tempo real"),),
      body: Padding(padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _cidadeController,
            decoration: InputDecoration(labelText: "Digite uma cidade"),
          ),
          ElevatedButton(onPressed: _buscar, child: Text("Buscar clima")),
          SizedBox(height: 10,),
          Divider(),
          if(_clima != null) ...[
            Text("Cidade: ${_clima!.cidade}"),
            Text("Temperatura: ${_clima!.temperatura} °C"),
            Text("Descrição: ${_clima!.descricao}")
          ] else if(_erro != null) ...[
            Text(_erro!)
          ] else ... [
            Text("Procure uma cidade")
          ]
        ],
      ),
    ));
  }
}
