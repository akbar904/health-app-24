import 'package:my_app/app/app.bottomsheets.dart';
import 'package:my_app/app/app.dialogs.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:my_app/services/storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _storageService = locator<StorageService>();

  List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;

  bool _showCompleted = true;
  bool get showCompleted => _showCompleted;

  List<TodoModel> get filteredTodos => _showCompleted
      ? _todos
      : _todos.where((todo) => !todo.isCompleted).toList();

  Future<void> initialize() async {
    setBusy(true);
    _todos = await _storageService.loadTodos();
    setBusy(false);
  }

  void toggleShowCompleted() {
    _showCompleted = !_showCompleted;
    rebuildUi();
  }

  Future<void> addTodo(String title) async {
    if (title.trim().isEmpty) return;

    final todo = TodoModel(
      id: DateTime.now().toIso8601String(),
      title: title.trim(),
      createdAt: DateTime.now(),
    );

    _todos.add(todo);
    await _storageService.saveTodos(_todos);
    rebuildUi();
  }

  Future<void> toggleTodo(TodoModel todo) async {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo.copyWith(
        isCompleted: !todo.isCompleted,
        completedAt: !todo.isCompleted ? DateTime.now() : null,
      );
      await _storageService.saveTodos(_todos);
      rebuildUi();
    }
  }

  Future<void> deleteTodo(TodoModel todo) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.confirmDelete,
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
    );

    if (response?.confirmed ?? false) {
      _todos.removeWhere((t) => t.id == todo.id);
      await _storageService.saveTodos(_todos);
      rebuildUi();
    }
  }

  Future<void> showTodoOptions(TodoModel todo) async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.todoOptions,
      data: todo,
    );

    if (response?.data == 'delete') {
      await deleteTodo(todo);
    } else if (response?.data == 'toggle') {
      await toggleTodo(todo);
    }
  }
}
