// classe para auxiliar nas chamadas da api

import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  // atributos e métodos da classe e não do obj
  // base URL para conexão API
  // static -> transforma o atributo em atributo da classe e não do obj
  static const String _baseUrl = 'http://10.109.197.43:3002';

  // métodos
  // GET (listar todos os recursos)
  static Future<List<dynamic>> getList(String path) async {
    final res = await http.get(Uri.parse("$_baseUrl/$path")); // uri -> converte string -> URL
    if(res.statusCode == 200) return json.decode(res.body); // deu certo converte a resposta de json para lista dynamic
    // não deu certo -> gerar um erro
    throw Exception("Falha ao carregar lista de $path");
  }

  // GET (listar um único recurso)
  static Future<Map<String,dynamic>> getOne(String path, String id) async{
    final res = await http.get(Uri.parse("$_baseUrl/$path/$id"));
    if(res.statusCode == 200) return json.decode(res.body);
    throw Exception("Falha ao carregar recurso de $path");
  }

  // POST (criar novo recurso)
  static Future<Map<String,dynamic>> post(String path, Map<String,dynamic> body) async {
    final res = await http.post(
      //endereço da api
      Uri.parse("$_baseUrl/$path"),
      // header
      headers: {"Content-Type/":"application/json"},
      body: json.encode(body)
      );
      if(res.statusCode == 201) return json.decode(res.body);
      throw Exception("Falha ao criar recurso em $path");
  }

  // PUT (atualizar recurso)
  static Future<Map<String,dynamic>> put(String path, Map<String,dynamic> body, String s) async {
    final res = await http.put(
      //endereço da api
      Uri.parse("$_baseUrl/$path"),
      // header
      headers: {"Content-Type/":"application/json"},
      body: json.encode(body)
      );
      if(res.statusCode == 201) return json.decode(res.body);
      throw Exception("Falha ao criar recurso em $path");
    }

  // DELETE (apagar recurso)
  static delete(String path, String id) async{
    final res = await http.delete(Uri.parse("$_baseUrl/$path/$id"));
    if (res.statusCode != 200) throw Exception("Falha ao deletar recurso $path");
  }
}