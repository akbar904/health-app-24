import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/home/home_viewmodel.dart';
import 'package:my_app/features/home/widgets/todo_add_button.dart';
import 'package:my_app/features/home/widgets/todo_list_item.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: viewModel.todos.isEmpty
          ? const Center(
              child: Text('No todos yet. Add one to get started!'),
            )
          : ListView.builder(
              itemCount: viewModel.todos.length,
              itemBuilder: (context, index) {
                final todo = viewModel.todos[index];
                return TodoListItem(
                  todo: todo,
                  onToggle: viewModel.toggleTodoCompletion,
                  onDelete: viewModel.deleteTodo,
                );
              },
            ),
      floatingActionButton: TodoAddButton(
        onPressed: viewModel.showAddTodoDialog,
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
