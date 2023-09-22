// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:app_todo_list/src/ui/page/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/todo_model.dart';

class TodoCheckboxWidget extends StatelessWidget {
  final TodoModel todo;

  const TodoCheckboxWidget({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todosCtrl = context.watch<HomeController>();

    return Checkbox(
      value: todosCtrl.isTodoChecked(todo.id),
      onChanged: (bool? isDone) {
        todosCtrl.checkTodo(todo.id);
      },
    );
  }
}
