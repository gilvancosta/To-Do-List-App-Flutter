// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../../../../domain/models/todo_model.dart';
import '../../../widgets/text/text_widget.dart';

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
          TextWidget(todo.title),
          TextWidget(todo.description),
        ],
      ),
    );
  }
}
