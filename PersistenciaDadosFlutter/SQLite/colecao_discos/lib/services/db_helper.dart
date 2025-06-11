import 'package:colecao_discos/models/colecaomodel.dart';
import 'package:colecao_discos/models/discosmodel.dart';
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
    final path = join(dbPath,"colecao_discos.db");

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
      disco_id INTEGER NOT NULL,
      dono TEXT NOT NULL,
      data_adicao TEXT NOT NULL)"""
    );
    print("tabela colecoes criada");

  // discos
    await db.execute(
      """CREATE TABLE IF NOT EXISTS discos(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      arista TEXT NOT NULL,
      descricao TEXT NOT NULL,
      ano INTEGER NOT NULL
      )"""
    );
    print("tabela discos criada");
    }
    Future<int> insertDisco(Discos discos) async{
      final db = await database;
      return await db.insert("discos", discos.toMap());
    }

    Future<List<Discos>> getDiscos() async{
      final db = await database;
      final List<Map<String,dynamic>> maps = await db.query("discos");
      return maps.map((e)=>Discos.fromMap(e)).toList();
    }

    Future<int> updateDisco(Discos discos) async{
      final db = await database;
      return await db.update(
        "discos",
        discos.toMap(),
        where: "id = ?",
        whereArgs: [discos.id],
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