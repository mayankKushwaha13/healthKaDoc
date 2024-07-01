import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentsContainerDocProfile extends StatelessWidget {
  const AppointmentsContainerDocProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
        ),
    
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text(
                        "12",
                        style: GoogleFonts.acme(
                          fontSize: 50,
                          color: Colors.blue.shade300,
                        ),
                      ),
                    ),
                
                    SizedBox(
                      width: 100,
                      child: Text(
                        "Appointments Today",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: VerticalDivider(
                    color: Colors.blue.shade300,
                    thickness: 1,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      child: Text(
                        "02",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.acme(
                          fontSize: 50,
                          color: Colors.blue.shade300,
                        ),
                      ),
                    ),
                
                    SizedBox(
                      width: 100,
                      child: Text(
                        "Remaining Appointments",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: VerticalDivider(
                    color: Colors.blue.shade300,
                    thickness: 1,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      child: Text(
                        "72",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.acme(
                          fontSize: 50,
                          color: Colors.blue.shade300,
                        ),
                      ),
                    ),
                
                    SizedBox(
                      width: 100,
                      child: Text(
                        "Appointments Total",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

