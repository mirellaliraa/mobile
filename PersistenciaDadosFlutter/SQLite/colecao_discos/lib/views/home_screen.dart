import 'package:colecoes/controller/colecoescontroller.dart';
import 'package:colecoes/models/colecaomodel.dart';
import 'package:colecoes/views/criarcolecao.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  final _colecaoController = ColecoesController();
  List<Colecao> _colecoes = [];
  bool _isLoading = true;

  @override
  void initState(){
    super.initState();
    _carregarDados();
  }
  
  _carregarDados() async{
    setState(() {
      _isLoading = true;
    });
    try {
      _colecoes = await _colecaoController.readColecao();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exception: $e")));
    } finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Suas coleções"),),
      body: _isLoading
      ? Center(child: CircularProgressIndicator())
      : _colecoes.isEmpty
      ? Center(child: Text("Nenhuma coleção cadastrada"))
      : Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: _colecoes.length,
          itemBuilder: (context, index){
            final colecao = _colecoes[index];
            return Card(
              child: ListTile(
                title: Text(colecao.nome),
                subtitle: Text(colecao.descricao),
                trailing: Text(colecao.tipo),
            ),
            );
          },
        ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Adicionar nova coleção",
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) => CriarColecao()));
            _carregarDados();
        },
        ),
    );
  }
}