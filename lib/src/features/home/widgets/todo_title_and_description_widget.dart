// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:app_todo_list/src/models/todo_model.dart';

class TodoTitleAndDescriptionWidget extends StatelessWidget {
  final TodoModel todo;

  const TodoTitleAndDescriptionWidget({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(todo.title),
          Text(todo.description),
        ],
      ),
    );
  }
}
