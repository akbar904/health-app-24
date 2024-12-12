import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddTodoSheet extends StatelessWidget {
  final Function(SheetResponse)? completer;
  final SheetRequest request;

  const AddTodoSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add New Todo',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter todo description',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => completer?.call(
                  SheetResponse(confirmed: false),
                ),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  if (controller.text.isEmpty) return;
                  completer?.call(
                    SheetResponse(
                      confirmed: true,
                      data: controller.text,
                    ),
                  );
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
