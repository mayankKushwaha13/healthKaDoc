import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prescription/widgets/patientProfileWidgets/row_vital_container.dart';

class VitalsContainer extends StatelessWidget {
  const VitalsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Text(
                    "Vitals ",
                    style: GoogleFonts.lato(
                      color: Colors.pink.shade300,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    "(Last Visit)",
                    style: GoogleFonts.lato(
                      color: Colors.pink.shade300,
                    ),
                  )
                ],
              ),
              const RowVitalContainer(),
            ],
          ),
        ),
      ),
    );
  }
}