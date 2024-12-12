import 'package:flutter/material.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/todo.dart';
import 'package:my_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  TodoStatus? _filterStatus;
  List<Todo> get todos => _todoService.getTodos(filterStatus: _filterStatus);

  void initialize() {
    rebuildUi();
  }

  Future<void> addTodo() async {
    if (titleController.text.isEmpty) return;

    _todoService.addTodo(
      titleController.text,
      descriptionController.text,
    );

    titleController.clear();
    descriptionController.clear();
    rebuildUi();
  }

  Future<void> deleteTodo(String todoId) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.todoConfirm,
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
    );

    if (response?.confirmed ?? false) {
      _todoService.deleteTodo(todoId);
      rebuildUi();
    }
  }

  void toggleTodoStatus(String todoId) {
    _todoService.toggleTodoStatus(todoId);
    rebuildUi();
  }

  Future<void> showEditTodoDialog(Todo todo) async {
    titleController.text = todo.title;
    descriptionController.text = todo.description;

    final response = await _dialogService.showCustomDialog(
      variant: DialogType.todoConfirm,
      title: 'Edit Todo',
      description: 'Update this todo?',
    );

    if (response?.confirmed ?? false) {
      _todoService.updateTodo(
        todo.id,
        titleController.text,
        descriptionController.text,
      );
      titleController.clear();
      descriptionController.clear();
      rebuildUi();
    }
  }

  Future<void> showFilterBottomSheet() async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.todoFilter,
    );

    if (response != null) {
      _filterStatus = response.data as TodoStatus?;
      rebuildUi();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
