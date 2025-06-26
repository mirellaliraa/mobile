import 'package:colecoes/models/colecaomodel.dart';
import 'package:colecoes/services/db_helper.dart';

class Colecoescontroller {
  final DbHelper _dbHelper = DbHelper();

  Future<int> createColecao(Colecao colecao) async{
    return await _dbHelper.insertColecao(colecao);
  }

  Future<List<Colecao>> readColecao() async{
    return await _dbHelper.getColecao();
  }

  Future<int> updateColecao(Colecao colecao) async{
    return await _dbHelper.updateColecao(colecao);
  }
}