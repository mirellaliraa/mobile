import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){ // método principal para rodar a aplicação
  runApp(MaterialApp( // base de todos os widgets(elementos visuais do aplicativo)
    home: TelaPerfil(), 
    // routes: {

    // }, // rotas de navegação
    // theme: , // tema do aplicativo
    // darkTheme: , // tema alternativo
    debugShowCheckedModeBanner: false, // remove o banner vermelho de debug
  ));
}

class TelaPerfil extends StatefulWidget{ // tela dinâmica
  @override 
  State<TelaPerfil> createState() => _TelaPerfilState(); // chama a mudança
}

class _TelaPerfilState extends State<TelaPerfil>{ // realiza a construção da tela
  // atributos
  TextEditingController _nomeController = TextEditingController(); // receber os dados do input
  TextEditingController _idadeController = TextEditingController();

  String? _nome; // permite variaveis nulas
  String? _idade; // permite variaveis nulas

  String? _corSelecionada;

  String? _cor;

  Map<String,Color> coresDisponiveis = {
    "Azul": Colors.blue,
    "Verde": Colors.green,
    "Vermelho": Colors.red,
    "Amarelo": Colors.yellow,
    "Cinza": Colors.grey,
    "Preto": Colors.black,
    "Branco": Colors.white
  };

  // criar cor de fundo
  Color _corFundo = Colors.white;

  // métodos
  @override
  void initState() { // método para carregar informações antes de buildar a tela
  super.initState();
  _carregarPreferencias();
  }

  _carregarPreferencias() async{ // método assincrono (sem ordem de execução)
  // conectar com o shared preferences
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  setState(() { // mudança de estado
    _nome = _prefs.getString("nome");
    _idade = _prefs.getString("idade");
    _cor = _prefs.getString("cor");
    if(_cor != null){
      _corFundo = coresDisponiveis[_cor!]!; // !permite nulo
    }
    });
  }

  _salvarPreferencias() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _nome = _nomeController.text.trim();
    _idade = _idadeController.text.trim();
    _corFundo = coresDisponiveis[_cor!]!;

    await _prefs.setString("nome", _nome ?? ""); // armazena o nome
    await _prefs.setString("idade", _idade ?? ""); // armazena a idade como double
    await _prefs.setString("cor", _cor ?? "Branco"); // armazena a cor, caso nulo armazena branco
    setState(() {
      
    });
  }

  //build 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _corFundo,
      appBar: AppBar(title: Text("Meu perfil persistente"), backgroundColor: Colors.purple,),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: "Idade"),
              keyboardType: TextInputType.numberWithOptions(), // teclado para números
            ),
            SizedBox(height: 16,),
            DropdownButtonFormField(
              value: _cor,
              decoration: InputDecoration(labelText: "Cor favorita"),
              items: coresDisponiveis.keys.map(
                (cor){
                  return DropdownMenuItem(
                    value: cor,
                    child: Text(cor));
                }
              ).toList(), 
              onChanged: (valor){
                setState(() {
                  _cor = valor;
                });
              }),
              SizedBox(height: 16,),
              ElevatedButton(
                onPressed: _salvarPreferencias, child: Text("Salvar Dados")),
              SizedBox(height: 16,),
              Divider(),
              SizedBox(height: 16,),
              Text("Dados salvos:"),
              if(_nome != null) // usando if dentro dos elementos visuais
              Text("Nome: $_nome"),
              if(_idade != null)
              Text("Idade: $_idade"),
              if(_cor != null)
              Text("Cor favorita: $_cor")
          ],
        ),
      ),
    );
  }

}