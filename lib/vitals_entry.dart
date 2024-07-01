import 'package:flutter/material.dart';

class VitalsEntry extends StatelessWidget {
  final int index;
  final List<String> vitalOptions;
  final List<Map<String, String>> vitalsResults;
  final Function(int) onRemove;
  final Function(int, String, String) onUpdate;
  final VoidCallback onAdd;

  VitalsEntry({
    required this.index,
    required this.vitalOptions,
    required this.vitalsResults,
    required this.onRemove,
    required this.onUpdate,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Card(
          color: Colors.lightBlue[50],
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Vital ${index + 1}:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: DropdownButtonFormField(
                    value: vitalsResults[index]['vital'] ?? vitalOptions[0],
                    items: vitalOptions.map((String vital) {
                      return DropdownMenuItem(
                        value: vital,
                        child: Text(vital),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      onUpdate(index, 'vital', newValue!);
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
                    initialValue: vitalsResults[index]['result'] ?? '',
                    decoration: InputDecoration(
                      hintText: 'Enter result...',
                      border: InputBorder.none,
                    ),
                    maxLines: 3,
                    onChanged: (value) {
                      onUpdate(index, 'result', value);
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