import 'package:colecoes/controller/itemcontroller.dart';
import 'package:colecoes/models/itemmodel.dart';
import 'package:flutter/material.dart';

class CadastroItem extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CadastroItemState();
}

class _CadastroItemState extends State<CadastroItem>{
  final _formKey = GlobalKey<FormState>();
  final _itemController = ItemController();

  late String _nome;
  late String _descricao;
  late double _valor;
  late int _ano;

  Future<void> _salvarItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final novoItem = Item(
        nome: _nome,
        descricao: _descricao,
        valor: _valor,
        ano: _ano,
      );
      await _itemController.createItem(novoItem);
      Navigator.pop(context); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastrar Item")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nome do item"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => _nome = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Descrição"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => _descricao = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Valor"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => _valor = double.parse(value!),
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
                onPressed: _salvarItem,
                child: Text("Cadastrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}