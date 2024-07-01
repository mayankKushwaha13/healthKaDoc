import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TestEntry extends StatelessWidget {
  final int index;
  final List<Map<String, String>> tests;
  final Function(int) onRemove;
  final Function(int, String, String) onUpdate;
  final VoidCallback onAdd;

  const TestEntry({super.key, 
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
      color: Colors.indigo[50],
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
              style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold, color: Colors.red.shade700)
            ),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
                color: Colors.pink.shade900
              ),
              child: TextFormField(
                style: GoogleFonts.aBeeZee(color: Colors.white),
                initialValue: tests[index]['name'] ?? '',
                decoration: InputDecoration(
                  hintText: 'Enter test name',
                  hintStyle: GoogleFonts.aBeeZee(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  onUpdate(index, 'name', value);
                },
              ),
            ),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.pink.shade900,
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextFormField(
                style: GoogleFonts.aBeeZee(color: Colors.white),
                initialValue: tests[index]['message'] ?? '',
                decoration: InputDecoration(
                  hintText: 'Enter message',
                  hintStyle: GoogleFonts.aBeeZee(color: Colors.white70),
                  border: InputBorder.none,
                ),
                maxLines: 3,
                onChanged: (value) {
                  onUpdate(index, 'message', value);
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red,),
                  onPressed: () => onRemove(index),
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
