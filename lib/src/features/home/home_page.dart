import 'package:app_todo_list/src/features/home/widgets/todo_checkbox_widget.dart';
import 'package:app_todo_list/src/features/home/widgets/todo_title_and_description_widget.dart';
import 'package:flutter/material.dart';

import '../../models/todo_model.dart';
import 'widgets/todo_date_widget.dart';

final List<TodoModel> todos = [TodoModel(title: 'Task 01', description: 'descrição 1'), TodoModel(title: 'Task 02', description: 'descrição 2')];

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (_, int index) {
          final TodoModel todo = todos[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TodoCheckboxWidget(todo: todo),
              const SizedBox(width: 12),
              TodoTitleAndDescriptionWidget(todo: todo),
              const SizedBox(width: 12),
              TodoDateWidget(todo: todo),
            ],
          );
        },
      ),
    );
  }
}
