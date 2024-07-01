import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RowVitalContainer extends StatelessWidget {
  const RowVitalContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.ideographic,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Text(
                    "110/40  ",
                    style: GoogleFonts.acme(
                      color: Colors.blue.shade300,
                      fontSize: 20,
                    ),
                  ),
                  const Text(
                    "mm/Hg",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              const Text(
                "Blood Pressure",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Text(
                    "175  ",
                    style: GoogleFonts.acme(
                      color: Colors.blue.shade300,
                      fontSize: 20,
                    ),
                  ),
                  const Text(
                    "cm",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              const Text(
                "Height",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Text(
                    "72  ",
                    style: GoogleFonts.acme(
                      color: Colors.blue.shade300,
                      fontSize: 20,
                    ),
                  ),
                  const Text(
                    "BPM",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              const Text(
                "Pulse",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Text(
                    "82  ",
                    style: GoogleFonts.acme(
                      color: Colors.blue.shade300,
                      fontSize: 20,
                    ),
                  ),
                  const Text(
                    "Kg",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              const Text(
                "weight",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Text(
                    "21.6  ",
                    style: GoogleFonts.acme(
                      color: Colors.blue.shade300,
                      fontSize: 20,
                    ),
                  ),
                  const Text(
                    "Kg²/cm",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              const Text(
                "BMI",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Text(
                    "98%  ",
                    style: GoogleFonts.acme(
                      color: Colors.blue.shade300,
                      fontSize: 20,
                    ),
                  ),
                  const Text(
                    "SpO2",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              const Text(
                "Blood Oxygen",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}