import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prescription/pages/patient_profile_page.dart';
import 'package:prescription/widgets/drawer_widget.dart';
import 'package:prescription/widgets/header.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Header(),
          
              Container(
                alignment: Alignment.topCenter,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.pink.shade400,
                  border: Border.all(color: Colors.transparent),
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(100),bottomRight: Radius.circular(100))
                ),
          
                child: Text(
                  "Patients",
                  style: GoogleFonts.openSans(
          
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurStyle: BlurStyle.outer,
                        blurRadius: 15,
                        color: Colors.grey.shade400,
                        offset: const Offset(4, 4),
                      )
                    ]
                  ),
                  child: SizedBox(
                    height: 900,
                    child: ListView.builder(
                      itemCount: 100,
                      itemBuilder: (context,index){
                      return ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.pink.shade50,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: ((context) => const PatientProfilePage())));
                            },
                            child: Icon(Icons.person,
                            color: Colors.pink.shade400,
                            size: 30,),
                          ),
                        ),
                        title: Text(
                          "Name${index+1}",
                          style: GoogleFonts.lato(
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text("Date ● ${(["Male","Female"]..shuffle()).first}"),
                        trailing: const Icon(Icons.more_horiz,),
                      );
                    }
                    
                    ),
                  ),
                ),
              )
          ]
          ),
        ),
      ),
    );

  }
}