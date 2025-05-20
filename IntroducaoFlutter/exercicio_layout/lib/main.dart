import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Seu perfil"), 
      actions: [
        Padding(padding: const EdgeInsets.only(right: 10),
        child: Icon(
        Icons.add_a_photo,
        size: 30,
        ),
        ),
        Padding(padding: const EdgeInsets.only(right: 10),
        child: Icon(
        Icons.search,
        size: 30,
        ),
        ),Padding(padding: const EdgeInsets.only(right: 10),
        child: Icon(
        Icons.create,
        size: 30,
        ),
        ),
      ],
      ),
      body: Center(
        child: Column(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(90),
            child: Image.asset(
              "assets/img/image.png",
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            ),
            Text("Coragem",
            style: TextStyle(
              fontSize: 40,
              color: Colors.pink,
              fontWeight: FontWeight.bold,
            ),
           ),
            Text("Lugar Nenhum, Arkansas",
            style: TextStyle(
              fontSize: 20,
              color: const Color.fromARGB(255, 95, 95, 95),
            ),
          ),
          SizedBox(height: 20),
          Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 150, height: 150, color: const Color.fromARGB(255, 51, 8, 241)),
                  Container(width: 150, height: 150, color: Colors.green),
                  Container(width: 150, height: 150, color: Colors.red)
                ],
              )
        ],
        ),
      ),
    );
  }
}