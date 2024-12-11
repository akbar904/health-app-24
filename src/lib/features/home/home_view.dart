import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/ui/widgets/todo_list.dart';
import 'package:my_app/ui/widgets/empty_state.dart';
import 'home_viewmodel.dart';

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
        actions: [
          IconButton(
            icon: Icon(
              viewModel.showCompleted
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
            ),
            onPressed: viewModel.toggleShowCompleted,
          ),
        ],
      ),
      body: viewModel.todos.isEmpty
          ? const EmptyState(
              message: 'No todos yet!\nTap the + button to add one.',
            )
          : TodoList(
              todos: viewModel.showCompleted
                  ? viewModel.completedTodos
                  : viewModel.incompleteTodos,
              onToggle: viewModel.toggleTodoCompletion,
              onEdit: viewModel.editTodo,
              onDelete: viewModel.deleteTodo,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
