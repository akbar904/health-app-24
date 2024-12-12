import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/ui/widgets/todo_item.dart';
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
        centerTitle: true,
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: viewModel.todos.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final todo = viewModel.todos[index];
                return TodoItem(
                  todo: todo,
                  onToggle: () => viewModel.toggleTodo(todo),
                  onDelete: () => viewModel.deleteTodo(todo),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) => viewModel.initialize();
}
