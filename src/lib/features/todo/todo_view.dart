import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/todo/todo_viewmodel.dart';
import 'package:my_app/features/todo/widgets/todo_list_item.dart';
import 'package:my_app/features/todo/widgets/add_todo_form.dart';

class TodoView extends StackedView<TodoViewModel> {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TodoViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: viewModel.showFilterSheet,
          ),
        ],
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
                  onToggle: () => viewModel.toggleTodoStatus(todo.id),
                  onDelete: () => viewModel.deleteTodo(todo.id),
                  onEdit: () => viewModel.showEditDialog(todo),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  TodoViewModel viewModelBuilder(BuildContext context) => TodoViewModel();
}
