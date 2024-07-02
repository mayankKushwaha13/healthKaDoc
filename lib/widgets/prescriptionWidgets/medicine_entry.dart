import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicineEntry extends StatelessWidget {
  final int index;
  final List<String> medicineTypes;
  final List<String> doses;
  final List<String> durations;
  final List<String> frequencies;
  final List<String> timings;
  final List<Map<String, String>> medicines;
  final Function(int) onRemove;
  final Function(int, String, String) onUpdate;
  final VoidCallback onAdd;

  const MedicineEntry({super.key, 
    required this.index,
    required this.medicineTypes,
    required this.doses,
    required this.durations,
    required this.frequencies,
    required this.timings,
    required this.medicines,
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
                'Medicine ${index + 1}:',
                style: GoogleFonts.aBeeZee(color: Colors.red.shade700,fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Medicine Name:', style: TextStyle(fontWeight: FontWeight.bold),),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.pink.shade900,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextFormField(
                  style: GoogleFonts.aBeeZee(color: Colors.white),
                  initialValue: medicines[index]['name'] ?? '',
                  decoration: InputDecoration(
                    hintText: 'Enter medicine name',
                    hintStyle: GoogleFonts.aBeeZee(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    onUpdate(index, 'name', value);
                  },
                ),
              ),
              const SizedBox(height: 8),
              const Text('Medicine Type:',style: TextStyle(fontWeight: FontWeight.bold),),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.pink.shade900,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButtonFormField(
                  value: medicines[index]['type'] ?? medicineTypes[0],
                  dropdownColor: Colors.pink.shade900,
                  iconEnabledColor: Colors.white,
                  items: medicineTypes.map((String type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type,style: GoogleFonts.aBeeZee(color: Colors.white),),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    onUpdate(index, 'type', newValue.toString());
                  },
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Dose:',style: TextStyle(fontWeight: FontWeight.bold),),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            color: Colors.pink.shade900,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: DropdownButtonFormField(
                            dropdownColor: Colors.pink.shade900,
                            iconEnabledColor: Colors.white,
                            value: medicines[index]['dose'] ?? doses[0],
                            items: doses.map((String dose) {
                              return DropdownMenuItem(
                                value: dose,
                                child: Text(dose,style: GoogleFonts.aBeeZee(color: Colors.white),),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              onUpdate(index, 'dose', newValue.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Duration:',style: TextStyle(fontWeight: FontWeight.bold),),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.pink.shade900
                          ),
                          child: DropdownButtonFormField(
                            dropdownColor: Colors.pink.shade900,
                            iconEnabledColor: Colors.white,
                            value: medicines[index]['duration'] ?? durations[0],
                            items: durations.map((String duration) {
                              return DropdownMenuItem(
                                value: duration,
                                child: Text(duration, style: GoogleFonts.aBeeZee(color: Colors.white),),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              onUpdate(index, 'duration', newValue.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Frequency:',style: TextStyle(fontWeight: FontWeight.bold),),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.pink.shade900
                          ),
                          child: DropdownButtonFormField(
                            iconEnabledColor: Colors.white,
                            dropdownColor: Colors.pink.shade900,
                            value: medicines[index]['frequency'] ?? frequencies[0],
                            items: frequencies.map((String frequency) {
                              return DropdownMenuItem(
                                value: frequency,
                                child: Text(frequency, style: GoogleFonts.aBeeZee(color: Colors.white),),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              onUpdate(index, 'frequency', newValue.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Timing:',style: TextStyle(fontWeight: FontWeight.bold),),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.pink.shade900
                          ),
                          child: DropdownButtonFormField(
                            dropdownColor: Colors.pink.shade900,
                            iconEnabledColor: Colors.white,
                            value: medicines[index]['timing'] ?? timings[0],
                            items: timings.map((String timing) {
                              return DropdownMenuItem(
                                value: timing,
                                child: Text(timing, style: GoogleFonts.aBeeZee(color: Colors.white),),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              onUpdate(index, 'timing', newValue.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Instructions:', style: TextStyle(fontWeight: FontWeight.bold),),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.pink.shade900
                ),
                child: TextFormField(
                  style: GoogleFonts.aBeeZee(color: Colors.white),
                  initialValue: medicines[index]['instructions'] ?? '',
                  decoration: InputDecoration(
                    hintText: 'Enter instructions',
                    hintStyle: GoogleFonts.aBeeZee(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    onUpdate(index, 'instructions', value);
                  },
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete,color: Colors.red,),
                    onPressed: () => onRemove(index),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}