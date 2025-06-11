import 'package:colecao_discos/controller/discoscontroller.dart';
import 'package:colecao_discos/models/discosmodel.dart';
import 'package:colecao_discos/views/cadastro_disco.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  final DiscosController _discosController = DiscosController();
  List<Discos> _discos = [];
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
      _discos = await _discosController.readDiscos();
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
      appBar: AppBar(title: Text("Coleção de discos"),),
      body: _isLoading
      ? Center(child: CircularProgressIndicator())
      : _discos.isEmpty
      ? Center(child: Text("Nenhum disco cadastrado"))
      : Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: _discos.length,
          itemBuilder: (context, index){
            final discos = _discos[index];
            return Card(
              child: ListTile(
                title: Text(discos.nome),
                subtitle: Text(discos.artista),
                trailing: Text(discos.ano.toString()),
            ),
            );
          },
        ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Adicionar novo pet",
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) => CadastroDisco()));
        },
        ),
    );
  }
}