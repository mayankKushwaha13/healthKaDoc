import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdviceSection extends StatelessWidget {
  final TextEditingController generalAdviceController;
  final TextEditingController referralController;
  final TextEditingController surgeryAdviceController;

  const AdviceSection({super.key, 
    required this.generalAdviceController,
    required this.referralController,
    required this.surgeryAdviceController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        color: Colors.indigo[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
        padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Additional Advice:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red.shade700),
        ),
        const SizedBox(height: 8),
        TextFormField(
          style: GoogleFonts.aBeeZee(color: Colors.white),
          controller: generalAdviceController,
          decoration: InputDecoration(
            fillColor: Colors.pink.shade900,
            filled: true,
            hintText: 'General Advice',
            hintStyle: GoogleFonts.aBeeZee(color: Colors.white70),
            border: const OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 8),
        TextFormField(
          style: GoogleFonts.aBeeZee(color: Colors.white),
          controller: referralController,
          decoration: InputDecoration(
            hintText: 'Referral',
            fillColor: Colors.pink.shade900,
            filled: true,
            hintStyle: GoogleFonts.aBeeZee(color: Colors.white70),
            border: const OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 8),
        TextFormField(
          style: GoogleFonts.aBeeZee(color: Colors.white),
          controller: surgeryAdviceController,
          decoration: InputDecoration(
            hintText: 'Surgery Advice',
            fillColor: Colors.pink.shade900,
            filled: true,
            hintStyle: GoogleFonts.aBeeZee(color: Colors.white70),
            border: const OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
      ],
    )
    )
    );
  }
}