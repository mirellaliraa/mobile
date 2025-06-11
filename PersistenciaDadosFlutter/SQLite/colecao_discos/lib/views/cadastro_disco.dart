import 'package:colecao_discos/controller/discoscontroller.dart';
import 'package:colecao_discos/models/discosmodel.dart';
import 'package:flutter/material.dart';

class CadastroDisco extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CadastroDiscoState();
}

class _CadastroDiscoState extends State<CadastroDisco>{
  final _formKey = GlobalKey<FormState>();
  final _discosController = DiscosController();

  late String _nome;
  late String _artista;
  late String _descricao;
  late int _ano;

  Future<void> _salvarDisco() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final novoDisco = Discos(
        nome: _nome,
        artista: _artista,
        descricao: _descricao,
        ano: _ano,
      );
      await _discosController.createDisco(novoDisco);
      Navigator.pop(context); // Volta para a tela anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastrar Disco")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nome do disco"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => _nome = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Artista"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => _artista = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Descrição"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => _descricao = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Ano"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Campo obrigatório";
                  if (int.tryParse(value) == null) return "Ano inválido";
                  return null;
                },
                onSaved: (value) => _ano = int.parse(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarDisco,
                child: Text("Cadastrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}