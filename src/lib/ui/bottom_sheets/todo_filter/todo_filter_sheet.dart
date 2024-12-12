import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoFilterSheet extends StatefulWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const TodoFilterSheet({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  State<TodoFilterSheet> createState() => _TodoFilterSheetState();
}

class _TodoFilterSheetState extends State<TodoFilterSheet> {
  late bool? _isCompleted;
  late String _searchQuery;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.request.data?['isCompleted'] as bool?;
    _searchQuery = (widget.request.data?['searchQuery'] as String?) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const Text(
            'Filter Todos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => _searchQuery = value,
            controller: TextEditingController(text: _searchQuery),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<bool?>(
            value: _isCompleted,
            decoration: const InputDecoration(
              labelText: 'Status',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: null,
                child: Text('All'),
              ),
              DropdownMenuItem(
                value: true,
                child: Text('Completed'),
              ),
              DropdownMenuItem(
                value: false,
                child: Text('Incomplete'),
              ),
            ],
            onChanged: (value) => setState(() => _isCompleted = value),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => widget.completer(SheetResponse()),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => widget.completer(
                  SheetResponse(
                    data: {
                      'isCompleted': _isCompleted,
                      'searchQuery': _searchQuery,
                    },
                  ),
                ),
                child: const Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}