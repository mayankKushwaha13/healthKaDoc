
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
  });
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  }