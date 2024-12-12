import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';
import 'widgets/add_todo_button.dart';
import 'widgets/todo_list.dart';

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
        title: const Text('Todo List'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: TodoList(
              todos: viewModel.todos,
              onTodoTap: viewModel.toggleTodoStatus,
              onTodoLongPress: viewModel.showTodoOptions,
            ),
          ),
        ],
      ),
      floatingActionButton: AddTodoButton(
        onPressed: viewModel.showAddTodoDialog,
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
