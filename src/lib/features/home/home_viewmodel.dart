import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.dialogs.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:my_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();

  List<TodoModel> get todos => _todoService.todos;

  bool get hasTodos => todos.isNotEmpty;

  Future<void> showAddTodoDialog() async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.todoForm,
      title: 'Add New Task',
    );

    if (response?.confirmed == true && response?.data != null) {
      final todo = response!.data as TodoModel;
      _todoService.addTodo(todo);
      rebuildUi();
    }
  }

  void toggleTodoComplete(String id) {
    _todoService.toggleTodoComplete(id);
    rebuildUi();
  }

  void deleteTodo(String id) {
    _todoService.deleteTodo(id);
    rebuildUi();
  }
}
