import 'package:stacked/stacked.dart';
import 'package:my_app/features/todo/models/todo_item.dart';

class TodoViewModel extends BaseViewModel {
  List<TodoItem> _todos = [];
  List<TodoItem> get todos => _todos;

  String _newTodoTitle = '';
  String get newTodoTitle => _newTodoTitle;

  void setNewTodoTitle(String value) {
    _newTodoTitle = value;
    notifyListeners();
  }

  void addTodo() {
    if (_newTodoTitle.trim().isEmpty) return;

    final newTodo = TodoItem(
      id: DateTime.now().toString(),
      title: _newTodoTitle.trim(),
    );

    _todos.add(newTodo);
    _newTodoTitle = '';
    notifyListeners();
  }

  void toggleTodoStatus(String id) {
    final todoIndex = _todos.indexWhere((todo) => todo.id == id);
    if (todoIndex != -1) {
      _todos[todoIndex].isCompleted = !_todos[todoIndex].isCompleted;
      notifyListeners();
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  void clearCompletedTodos() {
    _todos.removeWhere((todo) => todo.isCompleted);
    notifyListeners();
  }

  int get totalTodos => _todos.length;
  int get completedTodos => _todos.where((todo) => todo.isCompleted).length;
  int get pendingTodos => _todos.where((todo) => !todo.isCompleted).length;
}
