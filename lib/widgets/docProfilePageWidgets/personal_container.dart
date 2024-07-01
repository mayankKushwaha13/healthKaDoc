import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalContainerDocProfile extends StatelessWidget {
  const PersonalContainerDocProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "Personal Information",
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size:15,
                    ),
                  ),
                ],
              ),
            ),
    
            Divider(
              color: Colors.grey.shade200,
              thickness: 2,
            ),
    
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "Associated Clinics",
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size:15,
                    ),
                  ),
                ],
              ),
            ),
    
            Divider(
              color: Colors.grey.shade200,
              thickness: 2,
            ),
    
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "My Account",
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size:15,
                    ),
                  ),
                ],
              ),
            ),
    
            Divider(
              color: Colors.grey.shade200,
              thickness: 2,
            ),
    
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "LOG OUT",
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size:15,
                    ),
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}