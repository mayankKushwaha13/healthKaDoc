import 'package:flutter/material.dart';
import 'clinic_notes_page.dart';

void main() {
  runApp(ClinicNotesApp());
}

class ClinicNotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prescription',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ClinicNotesPage(),
    );
  }
}
