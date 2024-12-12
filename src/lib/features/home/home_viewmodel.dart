import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.bottomsheets.dart';
import 'package:my_app/app/app.dialogs.dart';
import 'package:my_app/features/todos/todo_model.dart';
import 'package:my_app/services/todo_service.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _dialogService = locator<DialogService>();

  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  Future<void> initialize() async {
    await runBusyFuture(_loadTodos());
  }

  Future<void> _loadTodos() async {
    _todos = await _todoService.getTodos();
    notifyListeners();
  }

  Future<void> addTodo() async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addTodo,
    );

    if (response?.confirmed == true && response?.data != null) {
      final description = response!.data as String;
      await _todoService.addTodo(description);
      await _loadTodos();
    }
  }

  Future<void> toggleTodo(Todo todo) async {
    await _todoService.toggleTodo(todo);
    await _loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.confirmDelete,
      description: 'Are you sure you want to delete "${todo.description}"?',
    );

    if (response?.confirmed == true) {
      await _todoService.deleteTodo(todo);
      await _loadTodos();
    }
  }
}
