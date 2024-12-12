import 'package:my_app/app/app.bottomsheets.dart';
import 'package:my_app/app/app.dialogs.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:my_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  List<TodoModel> get todos => _todoService.todos;

  Future<void> addTodo() async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addTodo,
    );

    if (response?.confirmed == true && response?.data != null) {
      final newTodo = response!.data as TodoModel;
      _todoService.addTodo(newTodo);
      rebuildUi();
    }
  }

  Future<void> editTodo(String todoId) async {
    final todo = _todoService.getTodoById(todoId);
    if (todo == null) return;

    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.editTodo,
      data: todo,
    );

    if (response?.confirmed == true && response?.data != null) {
      final updatedTodo = response!.data as TodoModel;
      _todoService.updateTodo(updatedTodo);
      rebuildUi();
    }
  }

  Future<void> deleteTodo(String todoId) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.deleteTodo,
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
    );

    if (response?.confirmed == true) {
      _todoService.deleteTodo(todoId);
      rebuildUi();
    }
  }

  void toggleTodoCompletion(String todoId) {
    _todoService.toggleTodoCompletion(todoId);
    rebuildUi();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Todo App',
      description: 'A simple todo app built with Stacked architecture',
    );
  }
}
