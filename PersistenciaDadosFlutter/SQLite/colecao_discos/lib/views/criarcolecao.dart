import 'package:colecao_discos/controller/colecoescontroller.dart';
import 'package:colecao_discos/models/colecaomodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CriarColecao extends StatefulWidget {
  final int discoId;

  CriarColecao({super.key, required this.discoId});

  @override
  State<CriarColecao> createState() => _CriarColecaoState();
}

class _CriarColecaoState extends State<CriarColecao> {
  final _formKey = GlobalKey<FormState>();
  final _colecaoControl = Colecoescontroller();

  late String _dono;
  late DateTime _dataAdicao;

  @override
  void initState() {
    super.initState();
    _dataAdicao = DateTime.now();
  }

  void _selecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataAdicao,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _dataAdicao) {
      setState(() {
        _dataAdicao = picked;
      });
    }
  }

  Future<void> _salvarColecao() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final novaColecao = Colecao(
        discoId: widget.discoId,
        dono: _dono,
        dataAdicao: _dataAdicao,
      );

      try {
        await _colecaoControl.createColecao(novaColecao);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Disco adicionado à coleção!")),
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
    final DateFormat dataFormatada = DateFormat("dd/MM/yyyy");

    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar à Coleção"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Dono"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => _dono = value!,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text("Data de adição: ${dataFormatada.format(_dataAdicao)}"),
                  ),
                  TextButton(
                    onPressed: () => _selecionarData(context),
                    child: Text("Selecionar data"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarColecao,
                child: Text("Adicionar à coleção"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}