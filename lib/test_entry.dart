import 'package:flutter/material.dart';

class TestEntry extends StatelessWidget {
  final int index;
  final List<Map<String, String>> tests;
  final Function(int) onRemove;
  final Function(int, String, String) onUpdate;
  final VoidCallback onAdd;

  TestEntry({
    required this.index,
    required this.tests,
    required this.onRemove,
    required this.onUpdate,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Card(
          elevation: 2,
          color: Colors.lightBlue[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Test ${index + 1}:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextFormField(
                    initialValue: tests[index]['name'] ?? '',
                    decoration: InputDecoration(
                      hintText: 'Enter test name',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      onUpdate(index, 'name', value);
                    },
                  ),
                ),
                SizedBox(height: 8),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextFormField(
                    initialValue: tests[index]['message'] ?? '',
                    decoration: InputDecoration(
                      hintText: 'Enter message',
                      border: InputBorder.none,
                    ),
                    maxLines: 3,
                    onChanged: (value) {
                      onUpdate(index, 'message', value);
                    },
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => onRemove(index),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: onAdd,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}