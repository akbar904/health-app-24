import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/models/todo.dart';
import 'package:my_app/app/services/todo_service.dart';
import 'package:my_app/enums/dialog_type.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();

  Todo? _todo;
  Todo? get todo => _todo;

  void initialize(Todo todo) {
    _todo = todo;
    rebuildUi();
  }

  void toggleTodo() {
    if (_todo != null) {
      _todoService.toggleTodoCompletion(_todo!.id);
      _todo = _todoService.todos.firstWhere((t) => t.id == _todo!.id);
      rebuildUi();
    }
  }

  Future<void> editTodo() async {
    if (_todo == null) return;

    final response = await _dialogService.showCustomDialog(
      variant: DialogType.custom,
      title: 'Edit Todo',
      description: 'Edit your todo item',
      data: _todo,
    );

    if (response?.confirmed == true && response?.data != null) {
      final updatedTodo = response!.data as Todo;
      _todoService.updateTodo(updatedTodo);
      _todo = updatedTodo;
      rebuildUi();
    }
  }

  Future<void> deleteTodo() async {
    if (_todo == null) return;

    final response = await _dialogService.showCustomDialog(
      variant: DialogType.custom,
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
      data: _todo,
    );

    if (response?.confirmed == true) {
      _todoService.deleteTodo(_todo!.id);
      _navigationService.back();
    }
  }
}