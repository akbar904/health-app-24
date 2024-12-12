import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/todo/widgets/todo_input.dart';
import 'package:my_app/features/todo/todo_viewmodel.dart';

class TodoView extends StackedView<TodoViewModel> {
  const TodoView({super.key});

  @override
  Widget builder(
    BuildContext context,
    TodoViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: viewModel.navigateBack,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TodoInput(
              controller: viewModel.todoController,
              onSubmit: viewModel.addTodo,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: viewModel.addTodo,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text(
                'Add Todo',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  TodoViewModel viewModelBuilder(BuildContext context) => TodoViewModel();

  @override
  void onDispose(TodoViewModel viewModel) {
    super.onDispose(viewModel);
    viewModel.dispose();
  }
}
