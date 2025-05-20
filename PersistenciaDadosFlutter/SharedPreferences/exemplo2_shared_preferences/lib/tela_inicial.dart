import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaInicial extends StatefulWidget{ // tela com mudança de estado
  @override
  State<TelaInicial> createState() => _TelaInicialState(); 
}

class _TelaInicialState extends State<TelaInicial>{
  // atributos
  String _nome = ""; // _ indica que o atributo é privado
  String _email = "";
  TextEditingController _nomeController = TextEditingController(); // controlador do Campo de texto
  TextEditingController _emailController = TextEditingController();
  bool _darkMode = false; // atributo para o modo escuro
  bool _logado = false; // atributo para verificar se o usuário está logado

  // métodos
  @override
  void initState() {
    super.initState();
    _carregarPreferencias(); // carregar as preferencias do usuário -
    if(_logado){
      Navigator.pushNamed(context, "/principal"); // navega para tela principal
    } 
  }
  _carregarPreferencias() async {
    // conectar com o sharedpreferences
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _nome = _prefs.getString("nome") ?? ""; // carrega as informações da chave nome, caso nao tenha carrega ""
      _email = _prefs.getString("email") ?? ""; 
      _darkMode = _prefs.getBool("darkMode") ?? false;
      _logado = _prefs.getBool("logado") ?? false;
    });
  }

  _trocarTema() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = !_darkMode; // troca o tema
      _prefs.setBool("darkMode", _darkMode); // salva o tema no cache
    });
  }

  _logar() async{
    _nome = _nomeController.text.trim();
    _email = _emailController.text.trim();
    SharedPreferences _prefs = await SharedPreferences.getInstance(); // conecta com o shared
    if(_nomeController.text.trim().isEmpty || _emailController.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Preencha todos os campos")));
    }else if(_prefs.getString(_nome) == _email){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login realizado com sucesso")));
      _prefs.setString("nome", _nome); // salva o nome no cache
      _prefs.setBool("logado", true); // salva o login
      _nomeController.clear();
      _emailController.clear();
      Navigator.pushNamed(context, "/principal"); // navega para a tela principal
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login ou email inválido")));
    }
  }

  @override
  Widget build(BuildContext context){
    return AnimatedTheme(
      data: _darkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bem vindo ${_nome =="" ? "Visitante" : _nome}"), // se nome estiver vazio escreve visitante
          actions: [
            IconButton(
              onPressed: _trocarTema, // trocar tema 
              icon: Icon(_darkMode ? Icons.light_mode : Icons.dark_mode))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Fazer login", style: TextStyle(fontSize: 20),),
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: "Nome"),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () => _logar,
               child: Text("Logar"),
               ),
               SizedBox(height: 20,),
               ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/cadastro"),
                child: Text("Cadastrar"))
            ],
            ),
        )
      ),
    );
  }
}