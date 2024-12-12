import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/features/todo/todo_repository.dart';
import 'package:my_app/models/todo_model.dart';

class TodoViewModel extends BaseViewModel {
  final _todoRepository = TodoRepository();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;

  bool? _filterCompleted;
  String _searchQuery = '';

  void initialize() {
    _loadTodos();
  }

  void _loadTodos() {
    _todos = _todoRepository.filterTodos(
      isCompleted: _filterCompleted,
      searchQuery: _searchQuery,
    );
    rebuildUi();
  }

  Future<void> showAddDialog() async {
    final dialogResponse = await _dialogService.showCustomDialog(
      variant: DialogType.custom,
      title: 'Add Todo',
      mainButtonTitle: 'Add',
      data: AddTodoForm(
        onSubmit: (title, description) {
          final newTodo = TodoModel(
            id: DateTime.now().toString(),
            title: title,
            description: description,
            isCompleted: false,
            createdAt: DateTime.now(),
          );
          _todoRepository.addTodo(newTodo);
          _loadTodos();
        },
      ),
    );

    if (dialogResponse?.confirmed ?? false) {
      _loadTodos();
    }
  }

  Future<void> showEditDialog(TodoModel todo) async {
    final dialogResponse = await _dialogService.showCustomDialog(
      variant: DialogType.custom,
      title: 'Edit Todo',
      mainButtonTitle: 'Update',
      data: AddTodoForm(
        initialTitle: todo.title,
        initialDescription: todo.description,
        isEditing: true,
        onSubmit: (title, description) {
          final updatedTodo = todo.copyWith(
            title: title,
            description: description,
          );
          _todoRepository.updateTodo(updatedTodo);
          _loadTodos();
        },
      ),
    );

    if (dialogResponse?.confirmed ?? false) {
      _loadTodos();
    }
  }

  Future<void> deleteTodo(String id) async {
    final dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
      cancelTitle: 'Cancel',
      confirmationTitle: 'Delete',
    );

    if (dialogResponse?.confirmed ?? false) {
      _todoRepository.deleteTodo(id);
      _loadTodos();
    }
  }

  void toggleTodoStatus(String id) {
    _todoRepository.toggleTodoStatus(id);
    _loadTodos();
  }

  Future<void> showFilterSheet() async {
    final sheetResponse = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.custom,
      title: 'Filter Todos',
      data: {
        'isCompleted': _filterCompleted,
        'searchQuery': _searchQuery,
      },
    );

    if (sheetResponse?.data != null) {
      _filterCompleted = sheetResponse!.data['isCompleted'];
      _searchQuery = sheetResponse.data['searchQuery'];
      _loadTodos();
    }
  }
}
