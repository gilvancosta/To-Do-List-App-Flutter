import 'package:flutter/material.dart';
import '../../../../domain/models/todo_model.dart';
import '../../../widgets/text/text_widget.dart';

class TodoDateWidget extends StatelessWidget {
  final TodoModel todo;

  const TodoDateWidget({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: TextWidget(
        todo.date.toIso8601String(),
      ),
    );
  }
}
