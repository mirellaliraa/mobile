import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;
  final TextEditingController _tarefaField = TextEditingController();
  bool _invisivel = true;


  Future<void> _addFilmeFavorito() async {
    if (_tarefaField.text.trim().isEmpty || _user == null) return;
    await _db
        .collection("usuarios")
        .doc(_user!.uid)
        .collection("favoritos")
        .add({"titulo": _tarefaField.text.trim(), "criadoEm": Timestamp.now()});
    _tarefaField.clear();
  }

  Future<void> _atualizarFilmeFavorito(String docId, String novoTitulo) async {
    if (_user == null) return;
    await _db
        .collection("usuarios")
        .doc(_user!.uid)
        .collection("favoritos")
        .doc(docId)
        .update({"titulo": novoTitulo});
  }

  Future<void> _deletarFilmeFavorito(String docId) async {
    if (_user == null) return;
    await _db
        .collection("usuarios")
        .doc(_user!.uid)
        .collection("favoritos")
        .doc(docId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Favoritos")));
  }
}