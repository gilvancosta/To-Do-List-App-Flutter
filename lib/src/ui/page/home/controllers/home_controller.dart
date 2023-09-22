import 'package:flutter/material.dart';
import '../../../../domain/models/todo_model.dart';
import '../../../../domain/services/local_storage/todos_local_storage_service.dart';

class HomeController extends ChangeNotifier {
  final TodosLocalStorageService _todosLocalStorageService;

  HomeController(this._todosLocalStorageService);

  final List<TodoModel> todos = [];

  final List<String> doneTodos = [];

  Future<String?> loadTodos() async {
    final (String? error, List<TodoModel>? loadedTodos) = await _todosLocalStorageService.getTodos();

    if (error == null) {
      todos
        ..clear()
        ..addAll(loadedTodos!);

      sortTodosByDate();
    }

    return error;
  }

  void sortTodosByDate() {
    todos.sort((todoA, todoB) => todoA.date.compareTo(todoB.date));
    notifyListeners();
  }

  Future<String?> loadDoneTodos() async {
    final (String? error, List<String>? loadedDoneTodos) = await _todosLocalStorageService.getDoneTodos();

    if (error == null) {
      doneTodos
        ..clear()
        ..addAll(loadedDoneTodos!);
    }

    return error;
  }

  Future<String?> addTodo(TodoModel todo) async {
    todos.add(todo);
    final String? error = await saveTodos();

    if (error == null) {
      sortTodosByDate();
    }

    return error;
    // return 'ocorreu um erro';
  }

  Future<String?> saveTodos() async {
    return _todosLocalStorageService.setTodos(todos);
  }

  bool isTodoChecked(String id) {
    return doneTodos.indexWhere((checkedTodoId) => checkedTodoId == id) != -1;
  }

  Future<String?> checkTodo(String id) async {
    if (!isTodoChecked(id)) {
      doneTodos.add(id);
    } else {
      doneTodos.removeWhere((checkedTodoId) => checkedTodoId == id);
    }

    final String? error = await _todosLocalStorageService.setDoneTodos(doneTodos);

    if (error == null) {
      if (isTodoChecked(id)) {
        doneTodos.add(id);
      } else {
        doneTodos.removeWhere((checkedTodoId) => checkedTodoId == id);
      }

      notifyListeners();
    }

    return error;
  }
}
