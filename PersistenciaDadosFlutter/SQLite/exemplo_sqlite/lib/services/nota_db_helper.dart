import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/nota_model.dart';

class NotaDbHelper {
  // Singleton
  Database? _database; // classe de conexão com o BD

  static const String DB_NAME = "notas.db";
  static const TABLE_NAME = "notas";
  static const String CREATE_TABLE_SQL = "CREATE TABLE IF NOT EXISTS $TABLE_NAME(id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT NOT NULL, conteudo TEXT NOT NULL)";

  // métodos de conexão

  Future<Database> get database async{
    if(_database !=null){
      return _database!; // se ja tiver conexão retorna a mesma já estabelecida
    }
    _database = await _initDatabase();
    return _database!; // caso nao tenha conexão retorna uma nova conexão
  }

  Future<Database> _initDatabase() async{
    final dbPath = await getDatabasesPath(); // pegar o caminho do banco de dados
    final path = join(dbPath, DB_NAME); // o banco de dados e o caminho

    return await openDatabase(
      path,
      onCreate: (db,version) async {
        await db.execute(CREATE_TABLE_SQL);
      },
      version: 1,
      // implementar o upgrade version ()
    );
  }

  //crud (não precisa usar SQL)

  Future <int> insertNota(Nota nota) async{
    final db = await database;
    return db.insert(TABLE_NAME, nota.toMap());
  }

  //read
  Future<List<Nota>> getNotas() async{
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query(TABLE_NAME);
    return maps.map((e)=> Nota.fromMap(e)).toList();
  }

  //update
  Future<int> updateNota(Nota nota) async{
    if(nota.id == null){
      throw Exception();
    }
    final db = await database;
      return await db.update(
        TABLE_NAME,
        nota.toMap(),
        where: "id = ?",
        whereArgs: [nota.id]
        );
  }
  // deleteBD
  Future<void> deleteNota(int id) async{
    final db = await database;
    return await db.delete(
      TABLE_NAME,
      where: "id=?",
      where [id]
    );
  }
}