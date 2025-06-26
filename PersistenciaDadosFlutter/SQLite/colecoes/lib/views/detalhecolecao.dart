import 'package:flutter/material.dart';
import 'package:colecoes/models/colecaomodel.dart';
import 'package:colecoes/views/cadastroitem.dart';

class DetalheColecao extends StatelessWidget {
  final Colecao colecao;

  DetalheColecao({required this.colecao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(colecao.nome)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Descrição: ${colecao.descricao}", style: TextStyle(fontSize: 16)),
            Text("Tipo: ${colecao.tipo}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text("Itens desta coleção:", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: Center(
                child: Text(
                  "Nenhum item cadastrado ainda.",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "Adicionar novo item",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroItem()),
          );
        },
      ),
    );
  }
}