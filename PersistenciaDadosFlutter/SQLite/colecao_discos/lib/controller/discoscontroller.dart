import 'package:colecao_discos/models/discosmodel.dart';
import 'package:colecao_discos/services/db_helper.dart';

class DiscosController {
  final DbHelper _dbHelper = DbHelper();

  Future<int> createDisco(Discos discos) async{
    return await _dbHelper.insertDisco(discos);
  }

  Future<List<Discos>> readDiscos() async{
    return await _dbHelper.getDiscos();
  }

  Future<int> updateDisco(Discos discos) async{
    return await _dbHelper.updateDisco(discos);
  }
}