import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Galeria()));
}

class Galeria extends StatefulWidget{
 @override
 GaleriaAppState createState() => _GaleriaAppState();
}

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
              onPressed: () {
                
              },            
          ),
          title: const Text('GridView'), 
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Aqui vai o dashboard'),
        ),
      ),
    );
  }