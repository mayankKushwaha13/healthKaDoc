import 'package:flutter/material.dart';


class DiagnosisSection extends StatelessWidget {
  final TextEditingController diagnosisController;

  DiagnosisSection({required this.diagnosisController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Diagnosis:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: diagnosisController,
          decoration: InputDecoration(
            hintText: 'Enter diagnosis',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}