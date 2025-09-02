import 'package:biblioteca_app/controllers/usuario_controller.dart';
import 'package:biblioteca_app/models/usuario_model.dart';
import 'package:biblioteca_app/views/usuarios/usuario_form_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UsuarioListView extends StatefulWidget {
  const UsuarioListView({super.key});

  @override
  State<UsuarioListView> createState() => _UsuarioListViewState();
}

class _UsuarioListViewState extends State<UsuarioListView> {
  // atributos
  final _buscarField = TextEditingController();
  List<UsuarioModel> _usuariosFiltrados = [];
  final _controller =
      UsuarioController(); // controller para conectar movel/view
  List<UsuarioModel> _usuarios = []; // lista para guardar os usuários
  bool _carregando = true; // bool para usar no view

  @override
  void initState() {
    // carregar os dados antes da construção da tela
    super.initState();
    _load(); // método para carregar dados da api
  }

  _load() async {
    setState(() {
      // modifica a variável para false - terminou de carregar
      _carregando = true;
    });
    try {
      _usuarios = await _controller
          .fetchAll(); // preenche a lista de usuário com os usuários do DB
      _usuariosFiltrados = _usuarios;
    } catch (e) {
      // caso erro mostra para o usuário
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      _carregando = false;
    });
  }

  // método para filtrar usuários pelo nome e pelo email
  void _filtrar() {
    // filtrar da lista já carregada
    final busca = _buscarField.text.toLowerCase();
    setState(() {
      _usuariosFiltrados = _usuarios.where((user) {
        return user.nome.toLowerCase().contains(busca) || // filtro pelo nome
            user.email.toLowerCase().contains(busca);
      }).toList();
    });
  }

  // criar método deletar
  void _delete(UsuarioModel user) async {
    if (user.id == null) return; // interrompe o método
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmar exclusão"),
        content: Text("Deseja realmente excluir o usuário ${user.nome}?"),
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
        await _controller.delete(user.id!);
        _load();
        // mensagem de confirmação
      } catch (e) {
        // tratar erro
      }
    }
  }

  // método para navegar para Tela User_form_view

  void _openForm({UsuarioModel? user}) async {
    // usuário entra no parâmetro, mas não é obrigatório
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UsuarioFormView(user: user)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // operador ternário
      body: _carregando
          ? Center(
              child: CircularProgressIndicator(),
            ) // mostra uma barra circular(
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _buscarField,
                    decoration: InputDecoration(labelText: "Pesquisar usuário"),
                    onChanged: (value) => _filtrar(),
                  ),
                ),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    // mostra a lista de usuário
                    padding: EdgeInsets.all(8),
                    itemCount: _usuariosFiltrados.length,
                    itemBuilder: (context, index) {
                      final usuario = _usuarios[index];
                      return Card(
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () => _openForm(user: usuario),
                            icon: Icon(Icons.edit),
                          ),
                          title: Text(usuario.nome),
                          subtitle: Text(usuario.email),
                          //trailing para deletar usuário
                          trailing: IconButton(
                            onPressed: () => _delete(usuario),
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
