import 'package:colecoes/models/itemmodel.dart';
import 'package:colecoes/services/db_helper.dart';

class ItemController {
  final DbHelper _dbHelper = DbHelper();

  Future<int> createItem(Item itens) async{
    return await _dbHelper.insertItem(itens);
  }

  Future<List<Item>> readItem() async{
    return await _dbHelper.getItem();
  }

  Future<int> updateItem(Item itens) async{
    return await _dbHelper.updateItem(itens);
  }
}