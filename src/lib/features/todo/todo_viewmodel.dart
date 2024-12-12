import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/features/todo/todo_repository.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:my_app/enums/dialog_type.dart';
import 'package:my_app/enums/bottom_sheet_type.dart';
import 'package:my_app/features/todo/widgets/add_todo_form.dart';

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
    final result = await _dialogService.showCustomDialog(
      variant: DialogType.form,
      title: 'Add Todo',
      mainButtonTitle: 'Add',
      data: AddTodoForm(
        onSubmit: (String title, String description) {
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

    if (result?.confirmed ?? false) {
      _loadTodos();
    }
  }

  Future<void> showEditDialog(TodoModel todo) async {
    final result = await _dialogService.showCustomDialog(
      variant: DialogType.form,
      title: 'Edit Todo',
      mainButtonTitle: 'Update',
      data: AddTodoForm(
        initialTitle: todo.title,
        initialDescription: todo.description,
        isEditing: true,
        onSubmit: (String title, String description) {
          final updatedTodo = todo.copyWith(
            title: title,
            description: description,
          );
          _todoRepository.updateTodo(updatedTodo);
          _loadTodos();
        },
      ),
    );

    if (result?.confirmed ?? false) {
      _loadTodos();
    }
  }

  Future<void> deleteTodo(String id) async {
    final result = await _dialogService.showConfirmationDialog(
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
      cancelTitle: 'Cancel',
      confirmationTitle: 'Delete',
    );

    if (result?.confirmed ?? false) {
      _todoRepository.deleteTodo(id);
      _loadTodos();
    }
  }

  void toggleTodoStatus(String id) {
    _todoRepository.toggleTodoStatus(id);
    _loadTodos();
  }

  Future<void> showFilterSheet() async {
    final result = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.filter,
      title: 'Filter Todos',
      data: {
        'isCompleted': _filterCompleted,
        'searchQuery': _searchQuery,
      },
    );

    if (result?.data != null) {
      _filterCompleted = result!.data['isCompleted'] as bool?;
      _searchQuery = result.data['searchQuery'] as String;
      _loadTodos();
    }
  }
}