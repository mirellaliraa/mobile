import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TarefasView extends StatefulWidget {
  const TarefasView({super.key});

  @override
  State<TarefasView> createState() => _TarefasViewState();
}

class _TarefasViewState extends State<TarefasView> {
  // atributos
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;
  final TextEditingController _tarefaField = TextEditingController();

  // adicionar tarefa
  void _addTarefa() async {
    if (_tarefaField.text.trim().isEmpty)
      return; // return null = > interrompe o método
    // adicionar a tarefa no firebase
    await _db.collection("usuarios").doc(_user!.uid).collection("tarefas").add({
      "titulo": _tarefaField.text.trim(),
      "concluida": false,
      "dataCriacao": Timestamp.now(),
    });
    _tarefaField.clear();
  }

  // atualizar status da tarefa
  void _atualizarTarefa(String tarefaID, bool status) async {
    // atualiza o status
    await _db
        .collection("usuarios")
        .doc(_user!.uid)
        .collection("tarefas")
        .doc(tarefaID)
        .update({"concluida": !status});
  }

  // deletar tarefa
  void _deleteTarefa(String tarefaID) async {
    // deletar
    await _db
        .collection("usuarios")
        .doc(_user!.uid)
        .collection("tarefas")
        .doc(tarefaID)
        .delete();
  }

  // método para pegar as tarefas -> build da tela

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minha tarefa"),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          // empilhamento vertical de itens)
          children: [
            // +de 1 item
            TextField(
              controller: _tarefaField,
              decoration: InputDecoration(
                labelText: "Nova tarefa",
                border: OutlineInputBorder(),
                suffix: IconButton(
                  onPressed: _addTarefa,
                  icon: Icon(Icons.add, color: Colors.green),
                ),
              ),
            ),
            SizedBox(height: 16),
            // inserir a lista de tarefas do usuário
            // o que será exibido depende da busca no fireStore
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _db
                    .collection("usuarios")
                    .doc(_user!.uid)
                    .collection("tarefas")
                    .orderBy("dataCriacao", descending: true)
                    .snapshots(), // mede o instantâneo da pesquisa no firebase
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("Sem tarefa por enquanto"));
                  }
                  // exibir as tarefas
                  final tarefas = snapshot.data!.docs; // adiciona a busca ao vetor de tarefas
                  return ListView.builder(
                    itemCount: tarefas.length,
                    itemBuilder: (context, index){
                      final tarefa = tarefas[index]; // tarefas em formato json
                      // converter json => Map<string, dynamic>
                      final tarefaMap = tarefa.data() as Map<String, dynamic>;
                      // ajustar as variaveis  booleanas
                      bool concluida = tarefaMap["concluida"] == true ? true : false;
                      // bool concluida = tarefaMap["concluida"] == 1 ? true : false
                      // bool concluida = tarefaMap["concluida"] ?? false / se for nulo atribui false
                      // fazer o item da lista
                      return ListTile(
                        title: Text(tarefaMap["titulo"]),
                        leading: Checkbox(
                          value: concluida, 
                          onChanged: (value){
                            setState(() {
                              _atualizarTarefa(tarefa.id, concluida);
                            });
                          }),
                          trailing: IconButton(
                            onPressed: ()=> _deleteTarefa(tarefa.id), 
                            icon: Icon(Icons.delete, color: Colors.red,)),
                      );
                    });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// that was your first mistake
// you took your lucky break and broke it in two
// now what can be doooone for you?

// michelle, ma belle
// these are words that go together well
// my michelle
// michelle, ma belle
// sont des mots qui vont très bien ensemble
// très bien ensemble
// i love you, i love you, i loooove you !
// that's all i want to say
// until i find a waaaaaay
// i will say the only words i know that you'll understand
// my michelle !
