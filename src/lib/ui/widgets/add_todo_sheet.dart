import 'package:flutter/material.dart';
import 'package:my_app/app/models/todo.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddTodoSheet extends StatelessWidget {
  final Function(SheetResponse<Todo>)? completer;
  final SheetRequest request;

  const AddTodoSheet({
    required this.completer,
    required this.request,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddTodoSheetModel>.reactive(
      viewModelBuilder: () => AddTodoSheetModel(),
      builder: (context, model, child) => Container(
        padding: const EdgeInsets.all(20),
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
            Text(
              'Add New Todo',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
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
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
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
                      completer?.call(
                        SheetResponse(
                          confirmed: true,
                          data: model.getTodo(),
                        ),
                      );
                    }
                  },
                  child: const Text('Add'),
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
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  bool get isValid =>
      titleController.text.isNotEmpty && descriptionController.text.isNotEmpty;

  Todo getTodo() {
    return Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text,
      description: descriptionController.text,
      createdAt: DateTime.now(),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
