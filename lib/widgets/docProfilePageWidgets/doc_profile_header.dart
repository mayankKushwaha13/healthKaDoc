import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prescription/data/shared_preference.dart';

class DocProfileHeader extends StatelessWidget {
  const DocProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.pink.shade400,
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(45), bottomRight: Radius.circular(45)),
    
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 15),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Text("Profile",
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.white,
                    ),),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.blue.shade400,
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Text(
                    "Dr. ${SP.sp!.getString(SP.firstName)!}",
                    style: GoogleFonts.lato(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
