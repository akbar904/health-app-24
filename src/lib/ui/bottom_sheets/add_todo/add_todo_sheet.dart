import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/services/todo_service.dart';

class AddTodoSheet extends StatelessWidget {
  final Function(SheetResponse)? completer;
  final SheetRequest request;

  const AddTodoSheet({
    super.key,
    required this.completer,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddTodoSheetModel>.reactive(
      viewModelBuilder: () => AddTodoSheetModel(),
      builder: (context, model, child) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: model.titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: model.descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () =>
                      completer?.call(SheetResponse(confirmed: false)),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (model.isValid) {
                      model.addTodo();
                      completer?.call(SheetResponse(confirmed: true));
                    }
                  },
                  child: const Text('Add Todo'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddTodoSheetModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  bool get isValid =>
      titleController.text.isNotEmpty && descriptionController.text.isNotEmpty;

  void addTodo() {
    _todoService.addTodo(
      title: titleController.text,
      description: descriptionController.text,
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
