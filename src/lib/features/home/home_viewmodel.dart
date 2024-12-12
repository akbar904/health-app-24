import 'package:my_app/app/app.bottomsheets.dart';
import 'package:my_app/app/app.dialogs.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/todo.dart';
import 'package:my_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  List<Todo> get todos => _todoService.todos;

  Future<void> showAddTodoDialog() async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.addTodo,
    );

    if (response?.confirmed == true && response?.data != null) {
      final todo = Todo(
        id: DateTime.now().toString(),
        title: response!.data as String,
        isCompleted: false,
        createdAt: DateTime.now(),
      );
      _todoService.addTodo(todo);
      rebuildUi();
    }
  }

  void toggleTodoStatus(String id) {
    _todoService.toggleTodoStatus(id);
    rebuildUi();
  }

  Future<void> showTodoOptions(String id) async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.todoOptions,
    );

    if (response?.confirmed == true) {
      switch (response?.data) {
        case 'delete':
          _todoService.removeTodo(id);
          rebuildUi();
          break;
        case 'edit':
          _showEditTodoDialog(id);
          break;
      }
    }
  }

  Future<void> _showEditTodoDialog(String id) async {
    final todo = todos.firstWhere((todo) => todo.id == id);
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.addTodo,
      title: 'Edit Todo',
      data: todo.title,
    );

    if (response?.confirmed == true && response?.data != null) {
      _todoService.updateTodoTitle(id, response!.data as String);
      rebuildUi();
    }
  }
}
