import 'package:flutter/material.dart';

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

  MedicineEntry({
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
                'Medicine ${index + 1}:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Medicine Name:'),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextFormField(
                  initialValue: medicines[index]['name'] ?? '',
                  decoration: InputDecoration(
                    hintText: 'Enter medicine name',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    onUpdate(index, 'name', value);
                  },
                ),
              ),
              SizedBox(height: 8),
              Text('Medicine Type:'),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButtonFormField(
                  value: medicines[index]['type'] ?? medicineTypes[0],
                  items: medicineTypes.map((String type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    onUpdate(index, 'type', newValue.toString());
                  },
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dose:'),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: DropdownButtonFormField(
                            value: medicines[index]['dose'] ?? doses[0],
                            items: doses.map((String dose) {
                              return DropdownMenuItem(
                                value: dose,
                                child: Text(dose),
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
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Duration:'),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: DropdownButtonFormField(
                            value: medicines[index]['duration'] ?? durations[0],
                            items: durations.map((String duration) {
                              return DropdownMenuItem(
                                value: duration,
                                child: Text(duration),
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
              SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Frequency:'),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: DropdownButtonFormField(
                            value: medicines[index]['frequency'] ?? frequencies[0],
                            items: frequencies.map((String frequency) {
                              return DropdownMenuItem(
                                value: frequency,
                                child: Text(frequency),
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
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Timing:'),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: DropdownButtonFormField(
                            value: medicines[index]['timing'] ?? timings[0],
                            items: timings.map((String timing) {
                              return DropdownMenuItem(
                                value: timing,
                                child: Text(timing),
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
              SizedBox(height: 8),
              Text('Instructions:'),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextFormField(
                  initialValue: medicines[index]['instructions'] ?? '',
                  decoration: InputDecoration(
                    hintText: 'Enter instructions',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    onUpdate(index, 'instructions', value);
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
      ),
    );
  }
}