import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prescription/pages/records_page.dart';

class Records extends StatelessWidget {
  const Records({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0, -100, 0),
      height: 180,
      width: 180,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: [
        const SizedBox(height: 20,),
        SizedBox(
          height: 80,
          child: Image.asset('lib/assets/records.png',)
        ),
    
        const SizedBox(height: 16,),
    
        Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.green,
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const RecordsPage()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text("Manage Records",
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
