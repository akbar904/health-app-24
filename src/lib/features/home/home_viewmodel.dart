import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/todo.dart';
import 'package:my_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  bool _showCompleted = false;
  bool get showCompleted => _showCompleted;

  List<Todo> get filteredTodos => _todoService.filterTodos(
        showCompleted: _showCompleted,
      );

  void setShowCompleted(bool value) {
    _showCompleted = value;
    rebuildUi();
  }

  void toggleTodoCompletion(String id) {
    _todoService.toggleTodoCompletion(id);
    rebuildUi();
  }

  Future<void> showTodoDetails(Todo todo) async {
    await _dialogService.showCustomDialog(
      variant: DialogType.todoDetail,
      data: todo,
    );
  }

  Future<void> deleteTodo(String id) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.confirmDelete,
      description: 'Are you sure you want to delete this todo?',
    );

    if (response?.confirmed ?? false) {
      _todoService.deleteTodo(id);
      rebuildUi();
    }
  }

  Future<void> showAddTodoSheet() async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addTodo,
    );

    if (response?.confirmed ?? false) {
      final data = response?.data as Map<String, dynamic>;
      final todo = Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: data['title'],
        description: data['description'],
        createdAt: DateTime.now(),
      );
      _todoService.addTodo(todo);
      rebuildUi();
    }
  }
}
