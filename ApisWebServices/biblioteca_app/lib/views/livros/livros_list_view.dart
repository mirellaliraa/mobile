import 'package:biblioteca_app/controllers/livro_controller.dart';
import 'package:biblioteca_app/models/livro_model.dart';
import 'package:biblioteca_app/views/livros/livros_form_view.dart';
import 'package:flutter/material.dart';

class LivrosListView extends StatefulWidget {
  const LivrosListView({super.key});

  @override
  State<LivrosListView> createState() => _LivrosListViewState();
}

class _LivrosListViewState extends State<LivrosListView> {
  final _buscarField = TextEditingController();
  List<LivroModel> _livrosFiltrados = [];
  final _controller =
      LivroController(); 
  List<LivroModel> _livros = []; 
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
      _livros = await _controller
          .fetchAll(); 
      _livrosFiltrados = _livros;
    } catch (e) {
      ScaffoldMessenger.of(context,).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      _carregando = false;
    });
  }

  void _filtrar() {
    final busca = _buscarField.text.toLowerCase();
    setState(() {
      _livrosFiltrados = _livros.where((user) {
        return livro.titulo.toLowerCase().contains(busca) || 
            livro.autor.toLowerCase().contains(busca);
      }).toList();
    });
  }

  // criar método deletar
  void _delete(LivroModel livro) async {
    if (livro.id == null) return; 
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmar exclusão"),
        content: Text("Deseja realmente excluir o livro ${livro.titulo}?"),
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
        await _controller.delete(livro.id!);
        _load();
      } catch (e) {
      }
    }
  }

  void _openForm({LivroModel? livro}) async {
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => LivrosFormView(livro: livro)),
    );
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _carregando
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _buscarField,
                    decoration: InputDecoration(labelText: "Pesquisar livro"),
                    onChanged: (value) => _filtrar(),
                  ),
                ),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: _livrosFiltrados.length,
                    itemBuilder: (context, index) {
                      final livro = _livrosFiltrados[index];
                      return Card(
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () => _openForm(livro: livro),
                            icon: Icon(Icons.edit),
                          ),
                          title: Text(livro.titulo),
                          subtitle: Text(livro.autor),
                          trailing: IconButton(
                            onPressed: () => _delete(livro),
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}