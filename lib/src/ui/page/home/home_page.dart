import 'package:app_todo_list/src/ui/page/home/widgets/todo_checkbox_widget.dart';
import 'package:app_todo_list/src/ui/page/home/widgets/todo_title_and_description_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/todo_model.dart';

import '../../widgets/text/text_widget.dart';
import '../add_todo/add_todo_page.dart';
import 'controllers/home_controller.dart';
import 'widgets/add_todo_icon_widget.dart';
import 'widgets/loading_error_widget.dart';
import 'widgets/todo_date_widget.dart';

//final List<TodoModel> todos = [TodoModel(title: 'Task 01', description: 'descrição 1'), TodoModel(title: 'Task 02', description: 'descrição 2')];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      loadTodosAndDoneTodos();
    });
    super.initState();
  }

  Future<void> loadTodosAndDoneTodos() async {
    isLoading = true;
    error = null;

    //error = "Erro ao carregar as tarefas";

    final String? errorLoadingTodos = await context.read<HomeController>().loadTodos();

    if (context.mounted) {
      final String? errorLoadingDoneTodos = await context.read<HomeController>().loadDoneTodos();

      if (errorLoadingTodos != null || errorLoadingDoneTodos != null) {
        setState(() {
          error = errorLoadingTodos ?? errorLoadingDoneTodos;
        });
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  void _goToAddTodo() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const AddTodoScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoCtrl = context.watch<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
        actions: [AddTodoIconWidget(_goToAddTodo)],
      ),
      body: isLoading || error != null
          ? LoadingErrorWidget(
              isLoading: isLoading,
              loadTodosAndDoneTodos: loadTodosAndDoneTodos,
            )
          : todoCtrl.todos.isEmpty
              ? const Center(
                  child: TextWidget('Você ainda não possui nenhuma tarefa'),
                )
              : ListView.builder(
                  itemCount: todoCtrl.todos.length,
                  itemBuilder: (_, int index) {
                    final TodoModel todo = todoCtrl.todos[index];
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
