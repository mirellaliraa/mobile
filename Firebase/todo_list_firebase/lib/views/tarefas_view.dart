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
    if (_tarefaField.text.trim().isEmpty && _user != null) {
      await _db.collection("user").doc(_user!.uid).collection("tarefas").add({
        "titulo": _tarefaField.text.trim(),
        "concluida": false,
        "criadaEm": Timestamp.now(),
      });
      _tarefaField.clear();
    }
  }

  // atualizar status da tarefa

  // deletar tarefa

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
    );
  }
}

// that was your first mistake
// you took your lucky break and broke it in two
// now what can be doooone for you?
