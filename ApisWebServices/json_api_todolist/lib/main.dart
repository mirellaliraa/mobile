import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: TarefasPage()));
}

class TarefasPage extends StatefulWidget {
  // garantia de importação da herança bem sucedida
  const TarefasPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TarefasPageState();
  }
}

// faz a construção da lógica e da tela para mundança de estado
class _TarefasPageState extends State<TarefasPage> {
  // atributos
  List<Map<String,dynamic>> tarefas = []; //lista para armazenar a coleção de tarefas
  final TextEditingController _tarefaController = TextEditingController(); // controlar o textField
  String baseUrl = "http://10.109.197.47:3002/tarefas"; // endereço da API

  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  // get
  void _carregarTarefas() async {
    try {
      // fazer uma conexão http (instalar a biblioteca http)
      // fazer uma solicitação do tipo get
      final response = await http.get(Uri.parse(baseUrl)); // Uri.parse => String em URL
      if (response.statusCode == 200) {
        List<dynamic> dados = json.decode(response.body);
        setState(() {
          // atualiza o estado da página
          // convertendo a lista Json de dados em tarefa(item) por tarefa(item)
          tarefas = dados.map((item) => Map<String, dynamic>.from(item)).toList(); // mais difícil, nunca da erro
          // tarefas = dados.cast<Map<String, dynamic>>(); // mais fácil mas pode dar erro
          // tarefas = List<Map<String, dynamic>>.from(dados); // outra forma de fazer a conversão da lista
        });
      }
    } catch (e) {
      print("Erro ao carregar tarefas $e");
    }
  }

  // post
  void _adicionarTarefa(String titulo) async {
    try {
      final tarefa = {"titulo": titulo, "concluida": false}; // Map -> Dart
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-type": "application/json"},
        body: json.encode(tarefa), // Map/dart -> Text/json
      );
      if (response.statusCode == 201) {
        _tarefaController.clear();
        _carregarTarefas();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tarefa adicionada com sucesso"))
        );
      }
    } catch (e) {
      print("Erro ao inserir tarefa: $e");
    }
  }

  // patch ou put
  void _atualizarTarefa(String id, bool concluida) async {
    try {
      final statusTarefa = {"concluida":!concluida};
      final response = await http.patch(
        Uri.parse("$baseUrl/$id"),
        headers: {"Content-type": "application/json"},
        body: json.encode(statusTarefa),
      );
      if (response.statusCode == 200) {
        _carregarTarefas();
      }
    } catch (e) {
      print("Erro ao atualizar tarefa: $e");
    }
  }

  // delete
  void _removerTarefa(String id) async {
    try {
      // solicitação http -> delete (url + id)
      final response = await http.delete(Uri.parse("$baseUrl/$id"));
      if (response.statusCode == 200) {
        _carregarTarefas();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Tarefa removida com sucesso")));
      }
    } catch (e) {
      print("Erro ao remover tarefa $e");
    }
  }

  // build tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tarefas via API")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tarefaController,
              decoration: InputDecoration(
                labelText: "Nova tarefa",
                border: OutlineInputBorder(),
              ),
              onSubmitted: _adicionarTarefa,
            ),
            SizedBox(height: 10),
            Expanded(
              // operador ternário
              child: tarefas.isEmpty
                  ? Center(child: Text("Nenhuma tarefa adicionada"))
                  : ListView.builder(
                      itemCount: tarefas.length,
                      itemBuilder: (context, index) {
                        final tarefa = tarefas[index];
                        return ListTile(
                          // elemento do meu listview
                          // leading (checkbox) - atualizar conclusão da tarefa
                          title: Text(tarefa["titulo"]),
                          subtitle: Text(
                            tarefa["concluída"] ? "Concluida" : "Pendente",
                          ),
                          trailing: IconButton(
                            onPressed: () => _removerTarefa(tarefa["id"]),
                            icon: Icon(Icons.delete),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
