import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/home/home_viewmodel.dart';
import 'package:my_app/features/home/widgets/todo_list_item.dart';
import 'package:my_app/features/home/widgets/todo_empty_state.dart';
import 'package:my_app/features/home/widgets/add_todo_fab.dart';

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
        title: const Text('My Tasks'),
        centerTitle: true,
      ),
      body: viewModel.hasTodos
          ? ListView.builder(
              itemCount: viewModel.todos.length,
              itemBuilder: (context, index) {
                final todo = viewModel.todos[index];
                return TodoListItem(
                  todo: todo,
                  onToggleComplete: (value) =>
                      viewModel.toggleTodoComplete(todo.id),
                  onDelete: () => viewModel.deleteTodo(todo.id),
                );
              },
            )
          : const TodoEmptyState(),
      floatingActionButton: AddTodoFAB(
        onPressed: viewModel.showAddTodoDialog,
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
