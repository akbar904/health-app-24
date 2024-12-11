import 'package:my_app/app/app.dialogs.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:my_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _todoService = locator<TodoService>();

  List<TodoModel> get todos => _todoService.todos;
  List<TodoModel> get completedTodos => _todoService.getTodosByCompletion(true);
  List<TodoModel> get incompleteTodos =>
      _todoService.getTodosByCompletion(false);

  bool _showCompleted = false;
  bool get showCompleted => _showCompleted;

  void toggleShowCompleted() {
    _showCompleted = !_showCompleted;
    notifyListeners();
  }

  Future<void> addTodo() async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.addTodo,
    );

    if (response?.confirmed == true && response?.data != null) {
      final todo = TodoModel(
        id: DateTime.now().toString(),
        title: response!.data['title'],
        description: response.data['description'],
        createdAt: DateTime.now(),
      );
      _todoService.addTodo(todo);
      notifyListeners();
    }
  }

  Future<void> editTodo(TodoModel todo) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.editTodo,
      data: {
        'title': todo.title,
        'description': todo.description,
      },
    );

    if (response?.confirmed == true && response?.data != null) {
      final updatedTodo = todo.copyWith(
        title: response!.data['title'],
        description: response.data['description'],
      );
      _todoService.updateTodo(updatedTodo);
      notifyListeners();
    }
  }

  void toggleTodoCompletion(String id) {
    _todoService.toggleTodoCompletion(id);
    notifyListeners();
  }

  void deleteTodo(String id) {
    _todoService.deleteTodo(id);
    notifyListeners();
  }
}
