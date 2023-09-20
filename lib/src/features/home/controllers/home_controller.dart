import 'package:flutter/material.dart';

import '../../../models/todo_model.dart';
import '../../../services/local_storage/todos_local_storage_service.dart';

class HomeController extends ChangeNotifier {
  final TodosLocalStorageService _todosLocalStorage;

  HomeController(this._todosLocalStorage);

  final List<TodoModel> todos = [];

  final List<String> doneTodos = [];

  Future<String?> loadTodos() async {
    final (String? error, List<TodoModel>? loadedTodos) = await _todosLocalStorage.getTodos();

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
    final (String? error, List<String>? loadedDoneTodos) = await _todosLocalStorage.getDoneTodos();

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
  }

  Future<String?> saveTodos() async {
    return _todosLocalStorage.setTodos(todos);
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

    final String? error = await _todosLocalStorage.setDoneTodos(doneTodos);

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
