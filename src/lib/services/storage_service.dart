import 'dart:convert';
import 'package:my_app/models/todo_model.dart';

class StorageService {
  List<TodoModel> _todos = [];

  Future<List<TodoModel>> loadTodos() async {
    // Simulating a delay to show loading state
    await Future.delayed(const Duration(milliseconds: 500));
    return _todos;
  }

  Future<void> saveTodos(List<TodoModel> todos) async {
    // Simulating a delay for storage operation
    await Future.delayed(const Duration(milliseconds: 300));
    _todos = todos;
  }

  String encodeTodos(List<TodoModel> todos) {
    return json.encode(
      todos.map((todo) => todo.toJson()).toList(),
    );
  }

  List<TodoModel> decodeTodos(String todosString) {
    final List<dynamic> decodedList = json.decode(todosString);
    return decodedList
        .map((item) => TodoModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
