import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(home: ConfigPage()));
}

class ConfigPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConfigPageState();
  }
}

class _ConfigPageState extends State<ConfigPage> {
  // atributos
  bool temaEscuro = false;

  @override
  void initState() {
    super.initState();
    carregarPreferencias();
  }

  void carregarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();
  }
}
