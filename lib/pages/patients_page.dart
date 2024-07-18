import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prescription/pages/patient_profile_page.dart';
import 'package:prescription/widgets/drawer_widget.dart';
import 'package:prescription/widgets/header.dart';
import 'package:prescription/widgets/my_appbar_widget.dart';

import '../constants/API links/patientAPI.dart';
import '../data/patient_database.dart';
import '../data/shared_preference.dart';
import '../model/patient.dart';

import 'package:http/http.dart' as http;

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  String query = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPatientData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        body: FutureBuilder(
            future: PatientDatabase().readPatientData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Patient> patientList = snapshot.data!;
                patientList = patientList.where((e)=>e.clinicID == SP.sp!.getString(SP.currClinic)).toList();
                patientList = patientList
                    .where((e) => e.patientName.toLowerCase().contains(query))
                    .toList();

                return SingleChildScrollView(
                  child: Column(children: [
                    Header(
                      onChanged: (value) {
                        setState(() {
                          query = value.toLowerCase();
                        });
                      },
                    ),
                    ClipPath(
                      clipper: BannerType(),
                      child: Container(
                        alignment: Alignment.center,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.pink.shade300,
                            border: Border.all(color: Colors.transparent),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(100),
                                bottomRight: Radius.circular(100))),
                        child: Text(
                          "Patients",
                          style: GoogleFonts.openSans(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    patientList.isEmpty
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                "No Record Found.",
                                style: GoogleFonts.josefinSans(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                            ],
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: patientList.length,
                            itemBuilder: (context, index) {
                              Patient patient = patientList[index];
                              return Card(
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 13, vertical: 5),
                                color: Colors.indigo.shade50,
                                child: ListTile(
                                  leading: Icon(
                                    CupertinoIcons.person_fill,
                                    color: Colors.indigo.shade700,
                                  ),
                                  title: Text(
                                    patient.patientName,
                                    style: GoogleFonts.lato(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Phone No. : ",
                                            style: GoogleFonts.aBeeZee(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            patient.phoneNumber,
                                            style: GoogleFonts.aBeeZee(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "First Visit : ",
                                            style: GoogleFonts.aBeeZee(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            patient.created_at
                                                .substring(0, 10)
                                                .split('-')
                                                .reversed
                                                .join('-'),
                                            style: GoogleFonts.aBeeZee(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Gender : ",
                                            style: GoogleFonts.aBeeZee(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            patient.gender[0].toUpperCase(),
                                            style: GoogleFonts.lato(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PatientProfilePage(
                                                  name: patient.patientName,
                                                )));
                                  },
                                ),
                              );
                            })
                  ]),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.pink.shade400,
                  ),
                );
              }
            }),
      ),
    );
  }

  getPatientData() async {
    final body = {
      'doctor_id': SP.sp!.getString(SP.user),
      'clinic_id': SP.sp!.getString(SP.currClinic)
    };
    var uri = Uri.parse("$patientAPI/get_all_patient_mobile");
    var response = await http.post(
      uri,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      List patientsData = result['data'];
      print(patientsData);
      List<Patient> localPatients = await PatientDatabase().readPatientData();
      print(localPatients);
      for (int i = 0; i < patientsData.length; i++) {
        int found =
            localPatients.indexWhere((e) => e.id == patientsData[i]['_id']);
        if (found == -1) {
          PatientDatabase().insertData(Patient.fromMap(patientsData[i]));
        }
      }
    } else {
      print(response.statusCode);
    }
    setState(() {});
  }
}
