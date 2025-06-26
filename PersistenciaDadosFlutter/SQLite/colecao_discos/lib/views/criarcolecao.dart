import 'package:colecoes/controller/colecoescontroller.dart';
import 'package:colecoes/models/colecaomodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CriarColecao extends StatefulWidget {

  CriarColecao({super.key});

  @override
  State<CriarColecao> createState() => _CriarColecaoState();
}

class _CriarColecaoState extends State<CriarColecao> {
  final _formKey = GlobalKey<FormState>();
  final _colecaoControl = Colecoescontroller();

  late String _nome;
  late String _descricao;
  late String _tipo;

  Future<void> _salvarColecao() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final novaColecao = Colecao(
        nome: _nome,
        descricao: _descricao,
        tipo: _tipo,
      );

      try {
        await _colecaoControl.createColecao(novaColecao);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Coleção criada com sucesso!")),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Coleção"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nome da coleção"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => _nome = value!,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: "Descrição"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => _descricao = value!,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _tipo,
                decoration: InputDecoration(labelText: "Tipo"),
                items: _tipos
                    .map((tipo) => DropdownMenuItem(
                          value: tipo,
                          child: Text(tipo),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _tipo = value!;
                  });
                },
                onSaved: (value) => _tipo = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarColecao,
                child: Text("Criar coleção"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}