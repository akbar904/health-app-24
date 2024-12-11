import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/home/home_viewmodel.dart';
import 'package:my_app/features/home/widgets/todo_input.dart';
import 'package:my_app/features/home/widgets/todo_item.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const TodoInput(),
          Expanded(
            child: viewModel.todos.isEmpty
                ? const Center(
                    child: Text(
                      'No todos yet!\nAdd your first todo to get started.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: viewModel.todos.length,
                    itemBuilder: (context, index) {
                      final todo = viewModel.todos[index];
                      return TodoItem(
                        todo: todo,
                        onToggle: () => viewModel.toggleTodoComplete(todo.id),
                        onDelete: () => viewModel.deleteTodo(todo.id),
                        onTap: () => viewModel.showTodoDetails(todo),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
