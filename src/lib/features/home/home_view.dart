import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/ui/widgets/todo_list.dart';
import 'home_viewmodel.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: viewModel.showDialog,
          ),
        ],
      ),
      body: TodoList(
        todos: viewModel.todos,
        onToggleTodo: viewModel.toggleTodoCompletion,
        onEditTodo: viewModel.editTodo,
        onDeleteTodo: viewModel.deleteTodo,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
