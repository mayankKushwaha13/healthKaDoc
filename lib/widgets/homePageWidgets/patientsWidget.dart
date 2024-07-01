import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prescription/pages/patients_page.dart';

class Patients extends StatelessWidget {
  const Patients({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0, -100, 0),
      height: 180,
      width: 180,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: [
        const SizedBox(height: 20,),
        SizedBox(
          height: 80,
          child: Image.asset('lib/assets/patient.png')
          ),
    
        const SizedBox(height: 16,),
    
        Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.blue,
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) => const PatientsPage())));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text("Manage Patients",
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),),
            ),
          ),
        )
      ]),
    );
  }
}

