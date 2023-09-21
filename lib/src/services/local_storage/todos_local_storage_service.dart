import 'dart:convert';
import 'dart:developer';


import 'package:app_todo_list/src/core/exception/local_storage_exception.dart';

import '../../core/consts/messages_consts.dart';
import '../../models/todo_model.dart';
import 'local_storage_service.dart';

class TodosLocalStorageService {
  final LocalStorageService _localStorageService;

  TodosLocalStorageService(this._localStorageService);

  Future<String?> setTodos(List<TodoModel> todos) async {
    try {
      final data = jsonEncode(todos.map((todo) => todo.toMap()).toList());

      await _localStorageService.set("todos", data);

      return null;
    } on LocalStorageException catch (error) {
      return error.message;
    } catch (error, st) {
      log('Error saving todos', error: error, stackTrace: st);
      return defaultErrorMessage;
    }
  }

  Future<(String? error, List<TodoModel>? todos)> getTodos() async {
    try {
      final todosJson = await _localStorageService.get("todos");

      if (todosJson != null) {
        final todos = (jsonDecode(todosJson) as List).map<TodoModel>((todo) => TodoModel.fromMap(todo)).toList();

        return (null, todos);
      }

      return (null, <TodoModel>[]);
    } on LocalStorageException catch (error) {
      return (error.message, null);
    } catch (error, st) {
      log('Error loading todos', error: error, stackTrace: st);
      return (defaultErrorMessage, null);
    }
  }

  Future<String?> setDoneTodos(List<String> doneTodos) async {
    try {
      final data = jsonEncode(doneTodos);

      await _localStorageService.set("doneTodos", data);

      return null;
    } on LocalStorageException catch (error) {
      return error.message;
    } catch (error, st) {
      log('Error saving done todos', error: error, stackTrace: st);
      return defaultErrorMessage;
    }
  }

  Future<(String? error, List<String>? doneTodos)> getDoneTodos() async {
    try {
      final doneTodosJson = await _localStorageService.get("doneTodos");

      if (doneTodosJson != null) {
        final doneTodos = (jsonDecode(doneTodosJson) as List).cast<String>();

        return (null, doneTodos);
      }

      return (null, <String>[]);
    } on LocalStorageException catch (error) {
      return (error.message, null);
    } catch (error, st) {
      log('Error loading done todos', error: error, stackTrace: st);
      return (defaultErrorMessage, null);
    }
  }
}
