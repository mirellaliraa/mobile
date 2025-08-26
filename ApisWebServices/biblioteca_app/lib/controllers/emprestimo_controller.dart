import 'package:biblioteca_app/models/emprestimo_model.dart';
import 'package:biblioteca_app/services/api_service.dart';

class EmprestimoController {
  // GET - ALL
  Future<List<EmprestimoModel>> fetchAll() async {
    final list = await ApiService.getList("livros?_sort=nome");
    return list.map<EmprestimoModel>((item)=>EmprestimoModel.fromJson(item)).toList();
  }

  // GET - One
  Future<EmprestimoModel> fetchOne(String id) async{
    final emprestimo = await ApiService.getOne("emprestimos", id);
    return EmprestimoModel.fromJson(emprestimo);
  }

  // POST
  Future<EmprestimoModel> create(EmprestimoModel u) async {
    final created = await ApiService.post("emprestimos", u.toJson());
    return EmprestimoModel.fromJson(created);
  }

  // PUT
  Future<EmprestimoModel> update(EmprestimoModel u) async{
    final updated = await ApiService.put("emprestimos", u.toJson(), u.id!);
    return EmprestimoModel.fromJson(updated);
  }

  //Delete
  Future<void> delete(String id) async{
    await ApiService.delete("emprestimos", id);
  }
}
