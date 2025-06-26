import 'package:colecoes/models/colecaomodel.dart';
import 'package:colecoes/models/itemmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static Database? _database;
  static final DbHelper _instance = DbHelper._internal();
  DbHelper._internal();
  factory DbHelper() => _instance;

  Future<Database> get database async{
    if (_database != null){
      return _database!;
    }else{
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<Database> _initDatabase() async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath,"colecoes.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateDB
      );
  }

  Future<void> _onCreateDB(Database db, int version) async{
    // coleções
    await db.execute(
      """CREATE TABLE IF NOT EXISTS colecao(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      descricao TEXT NOT NULL,
      tipo TEXT NOT NULL
      )"""
    );
    print("tabela colecoes criada");

  // itens
    await db.execute(
      """CREATE TABLE IF NOT EXISTS itens(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      descricao TEXT NOT NULL,
      valor REAL NOT NULL,
      ano INTEGER NOT NULL
      )"""
    );
    print("tabela itens criada");
    }
    Future<int> insertItem(Item itens) async{
      final db = await database;
      return await db.insert("itens", itens.toMap());
    }

    Future<List<Item>> getItem() async{
      final db = await database;
      final List<Map<String,dynamic>> maps = await db.query("itens");
      return maps.map((e)=>Item.fromMap(e)).toList();
    }

    Future<int> updateItem(Item itens) async{
      final db = await database;
      return await db.update(
        "itens",
        itens.toMap(),
        where: "id = ?",
        whereArgs: [itens.id],
        );
    }

    Future<int> insertColecao(Colecao colecao) async{
      final db = await database;
      return await db.insert("colecao", colecao.toMap());
    }

    Future<List<Colecao>> getColecao() async{
      final db = await database;
      final List<Map<String,dynamic>> maps = await db.query("colecao");
      return maps.map((e)=>Colecao.fromMap(e)).toList();
    }

    Future<int> updateColecao(Colecao colecao) async{
      final db = await database;
      return await db.update(
        "colecao",
        colecao.toMap(),
        where: "id = ?",
        whereArgs: [colecao.id],
        );
    }
}