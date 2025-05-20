import 'package:flutter/material.dart';
import 'package:sa03_navegacao/views/TelaBoasVindas.dart';
import 'package:sa03_navegacao/views/TelaCadastro.dart';
import 'package:sa03_navegacao/views/TelaConfirmacao.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      // nome_da_rota => Telada()
      "/": (context) => TelaBoasVindas(),
      "/cadastro": (context) => TelaCadastro(),
      "/confirmacao": (context) => TelaConfirmacao(),
    },
  ));
}