import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prescription/pages/clinic_notes_page.dart';
import 'package:prescription/pages/home_page.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue.shade300,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Image.asset("lib/assets/healthka.png"),
          ),
          const Divider(
            thickness: 2,
            color: Colors.white,
          ),
          Container(
            color: Colors.blue.shade900,
            child: ListTile(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => route.isCurrent);
              },
              leading: Image.asset(
                "lib/assets/clinic.png",
                height: 24,
              ),
              title: Text(
                "Home",
                style: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 7,),
          Container(
            color: Colors.blue.shade900,
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const ClinicNotesPage()));
              },
              leading: Image.asset(
                "lib/assets/prescription.png",
                height: 24,
              ),
              title: Text(
                "Add Prescription",
                style: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
