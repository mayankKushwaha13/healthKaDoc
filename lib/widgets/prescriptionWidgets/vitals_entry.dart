import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VitalsEntry extends StatelessWidget {
  final int index;
  final List<String> vitalOptions;
  final List<Map<String, String>> vitalsResults;
  final Function(int) onRemove;
  final Function(int, String, String) onUpdate;
  final VoidCallback onAdd;

  const VitalsEntry({super.key, 
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
    color: Colors.indigo[50],
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
              style: GoogleFonts.aBeeZee(color: Colors.red.shade700, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(4),
                color: Colors.pink.shade900
              ),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none
                ),
                value: vitalsResults[index]['vital'] ?? vitalOptions[0],
                iconEnabledColor: Colors.white,
                dropdownColor: Colors.pink.shade900,
                items: vitalOptions.map((String vital) {
                  return DropdownMenuItem(
                    value: vital,
                    child: Text(vital,style: GoogleFonts.lato(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  onUpdate(index, 'vital', newValue!);
                },
              ),
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
                style: GoogleFonts.lato(color: Colors.white),
                initialValue: vitalsResults[index]['result'] ?? '',
                decoration: InputDecoration(
                  hintText: 'Enter result...',
                  hintStyle: GoogleFonts.lato(color: Colors.white70),
                  border: InputBorder.none,
                ),
                maxLines: 3,
                onChanged: (value) {
                  onUpdate(index, 'result', value);
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
