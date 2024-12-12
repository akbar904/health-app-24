import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/home/home_viewmodel.dart';
import 'package:my_app/features/home/widgets/todo_filter_bar.dart';
import 'package:my_app/features/home/widgets/todo_list_item.dart';

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
      ),
      body: Column(
        children: [
          TodoFilterBar(
            showCompleted: viewModel.showCompleted,
            onFilterChanged: viewModel.setShowCompleted,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.filteredTodos.length,
              itemBuilder: (context, index) {
                final todo = viewModel.filteredTodos[index];
                return TodoListItem(
                  todo: todo,
                  onToggle: () => viewModel.toggleTodoCompletion(todo.id),
                  onTap: () => viewModel.showTodoDetails(todo),
                  onDelete: () => viewModel.deleteTodo(todo.id),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.showAddTodoSheet,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
