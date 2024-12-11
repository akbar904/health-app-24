import 'package:my_app/app/app.dialogs.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/todo.dart';
import 'package:my_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();

  List<Todo> get todos => _todoService.getAllTodos();

  void toggleTodoComplete(String id) {
    _todoService.toggleTodoComplete(id);
    rebuildUi();
  }

  Future<void> deleteTodo(String id) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.confirmDelete,
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
    );

    if (response?.confirmed ?? false) {
      _todoService.deleteTodo(id);
      rebuildUi();
    }
  }

  void showTodoDetails(Todo todo) {
    _dialogService.showCustomDialog(
      variant: DialogType.todoDetails,
      data: todo,
    );
  }
}
