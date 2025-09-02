import 'package:biblioteca_app/models/emprestimo_model.dart';
import 'package:biblioteca_app/views/emprestimos/emprestimos_dart_view.dart';
import 'package:biblioteca_app/controllers/emprestimo_controller.dart';
import 'package:flutter/material.dart';

class EmprestimosListView extends StatefulWidget {
  const EmprestimosListView({super.key});

  @override
  State<EmprestimosListView> createState() => _EmprestimosListViewState();
}

class _EmprestimosListViewState extends State<EmprestimosListView> {
  final _controller = EmprestimoController();
  List<EmprestimoModel> _emprestimos = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() async {
    setState(() {
      _carregando = true;
    });
    try {
      _emprestimos = await _controller.fetchAll();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      _carregando = false;
    });
  }

  void _delete(EmprestimoModel emprestimo) async {
    if (emprestimo.id == null) return;
    final confirme = await showDialog<bool>(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Confirmar exclusão"),
      content: Text("Deseja realmente excluir o empréstimo ${emprestimo.id}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Confirmar"),
          ),
        ],
      ),
    );
    if (confirme == true) {
      try {
        await _controller.delete(emprestimo.id!);
        _load();
        // mensagem de confirmação
      } catch (e) {
        // tratar erro
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _carregando
      ? Center(
        child: ,
      ),
    );
  }
}
