import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

//class
class MyApp extends StatelessWidget{
  //construtor de widgets
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Exemplo"),),
      body: Center(
        child: Column(
          children: [
            Text("Exemplo de texto",
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue,
            ),),
            Text("Texto Personalizado",
            style: TextStyle(
              fontSize: 24,
              color: Colors.red,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              wordSpacing: 2,
              decoration: TextDecoration.underline,
            ),),
            //icones
            Icon(Icons.star, size:50, color: Colors.amber,),
            IconButton(
              onPressed: () => print("Icone pressionado") ,
              icon: Icon(Icons.add_a_photo), 
              iconSize: 50),
              //imagens
              Image.network("https://i0.wp.com/ovicio.com.br/wp-content/uploads/2021/09/20210912-scale.jpg?resize=555%2C555&ssl=1",
                width: 200, height: 200, fit: BoxFit.cover,),
              Image.asset("assets/img/image.png",
                width: 200, height: 200, fit: BoxFit.cover),
              //Box Exibição de imagem
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      "assets/img/image.png",
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                  ),
                ),
                ClipRRect(borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/img/image.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}