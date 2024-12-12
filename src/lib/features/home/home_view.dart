import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/home/widgets/todo_item.dart';
import 'package:my_app/features/home/widgets/todo_input.dart';

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
            icon: Icon(
              viewModel.showCompleted ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: viewModel.toggleShowCompleted,
            tooltip:
                viewModel.showCompleted ? 'Hide completed' : 'Show completed',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            TodoInput(
              onSubmit: viewModel.addTodo,
            ),
            const Gap(16),
            Expanded(
              child: viewModel.isBusy
                  ? const Center(child: CircularProgressIndicator())
                  : viewModel.filteredTodos.isEmpty
                      ? const Center(
                          child: Text('No todos yet! Add one above.'),
                        )
                      : ListView.builder(
                          itemCount: viewModel.filteredTodos.length,
                          itemBuilder: (context, index) {
                            final todo = viewModel.filteredTodos[index];
                            return TodoItem(
                              todo: todo,
                              onToggle: viewModel.toggleTodo,
                              onTap: viewModel.showTodoOptions,
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) => viewModel.initialize();
}
