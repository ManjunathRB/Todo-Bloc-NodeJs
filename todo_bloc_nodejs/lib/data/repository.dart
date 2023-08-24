// ignore_for_file: unnecessary_null_comparison

import 'package:todo_bloc_nodejs/data/network_service.dart';
import 'package:todo_bloc_nodejs/data/todo_model.dart';

class Repository {
  final NetworkService networkService;

  Repository({required this.networkService});
  Future<List<Todos>> fetchTodos() async {
    final todosRaw = await networkService.fetchTodos();
    return todosRaw.map((e) => Todos.fromJson(e)).toList();
  }

  Future<bool> changeCompletion(bool isCompleted, int id) async {
    final patchObj = {"isCompleted": isCompleted.toString()};

    return await networkService.patchTodo(patchObj, id);
  }

  Future<Todos?> addTodo(String message) async {
    final todoObj = {
      "todo": message,
      "isCompleted": "false",
      "date": "6/8/2023"
    };
    final todoMap = await networkService.addTodo(todoObj);
    if (todoMap == null) {
      return null;
    }
    return Todos.fromJson(todoMap);
  }

  Future<bool> deleteTodo(int id) async {
    return await networkService.deleteTodo(id);
  }

  Future<bool> updateTodo(String message, int id) async {
    final patchObj = {"todo": message.toString()};

    return await networkService.patchTodo(patchObj, id);
  }
}
