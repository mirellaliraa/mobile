// classe de apoio as conexões do banco de dados
// class Singleton -> de objeto unico

import 'package:path/path.dart';
import 'package:sa_petshop/models/consulta_model.dart';
import 'package:sa_petshop/models/pet_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  static Database? _database; // obj para criar as conexões com o BD
  // transformar a classe em Singleton
  // não permite instanciar outro objeto enquanto um obj estiver ativo
  static final DbHelper _instance = DbHelper._internal();
  // construtor para o singleton
  DbHelper._internal();
  factory DbHelper() => _instance;

  // fazer as conexões com o BD
  Future<Database> get database async{
    if (_database != null){
      return _database!;
    }else{
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<Database> _initDatabase() async{
    // pegar o endereço do banco de dados
    final dbPath = await getDatabasesPath();
    final path = join(dbPath,"petshop.db"); // caminho completo para o BD

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateDB
    );
  }

  Future<void> _onCreateDB(Database db, int version) async{
    // Criar a tabela dos pets
    await db.execute(
      """CREATE TABLE IF NOT EXISTS pets(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      raca TEXT NOT NULL,
      nome_dono TEXT NOT NULL,
      telefone TEXT NOT NULL
      )"""
    );
    print("tabela pet criada");
    // Criar a tabela das consultas
    await db.execute(
      """CREATE TABLE IF NOT EXISTS consultas(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      pet_id INTEGER NOT NULL,
      data_hora TEXT NOT NULL,
      tipo_servico TEXT NOT NULL,
      observacao TEXT,
      FOREIGN KEY (pet_id) REFERENCES pets(id) ON DELETE CASCADE
      )"""
    );
    print("tabela consultas criada");
  }

  // métodos CRUD para pets
  Future<int> insertPet(Pet pet) async{
    final db = await database;
    return await db.insert("pets", pet.toMap()); // retorna o id do Pet
  }

  Future<List<Pet>> getPets() async{
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query("pets"); // receber as infos do DB
    // converter os valores para obj
    return maps.map((e)=>Pet.fromMap(e)).toList();
  }

  Future<Pet?> getPetbyId(int id) async{
    final db = await database;
    final List<Map<String,dynamic>> maps = 
      await db.query("pets", where: "id=?", whereArgs: [id]);
    // se encontrando
    if(maps.isNotEmpty){
      return Pet.fromMap(maps.first); // cria o obj com 1° elemento da lista
    }else{
      return null;
    }
  }

  Future<int> deletePet(int id) async{
    final db = await database;
    return await db.delete("pets", where: "id=?", whereArgs: [id]);
    // deleta o pet da tabela que tenha o id igual o enviado como parâmetro
  }

  // métodos CRUD para consultas
  // create Consulta
  Future<int> insertConsulta(Consulta consulta) async{
    final db = await database;
    return await db.insert("consultas", consulta.toMap());
  }

  // get Consulta -> by Pet
  Future<List<Consulta>> getConsultaByPetId(int petId) async{
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query(
      "consultas",
      where: "petId = ?",
      whereArgs: [petId],
      orderBy: "data_hora ASC" // ordenar por data e hora da consulta
      );
      // converter a maps em obj
      return maps.map((e)=>Consulta.fromMap(e)).toList();
  }

  // Delete consulta
  Future<int> deleteConsulta(int id) async{
    final db = await database;
    return await db.delete("consultas", where: "id=?", whereArgs: [id]);
  }

}

// maybe we'll meet at a bar ! ^_^
// he'll drive a funky car :o
// maybe we'll meet at a club
// and fall so deeply in love!!