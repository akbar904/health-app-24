import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:my_app/services/todo_service.dart';

class TodoViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _navigationService = locator<NavigationService>();
  final todoController = TextEditingController();

  void addTodo() {
    if (todoController.text.trim().isEmpty) return;

    final todo = TodoModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: todoController.text.trim(),
      createdAt: DateTime.now(),
    );

    _todoService.addTodo(todo);
    todoController.clear();
    _navigationService.back();
  }

  void navigateBack() {
    _navigationService.back();
  }

  void dispose() {
    todoController.dispose();
  }
}
