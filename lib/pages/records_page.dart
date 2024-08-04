import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prescription/data/prescription_database.dart';
import 'package:prescription/functions/forPrescriptionAPI.dart';
import 'package:prescription/functions/getPrescription.dart';
import 'package:prescription/model/prescription.dart';
import 'package:prescription/pages/prescription_page.dart';
import 'package:prescription/widgets/drawer_widget.dart';
import 'package:prescription/widgets/header.dart';

import '../data/shared_preference.dart';
import '../widgets/my_appbar_widget.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  String query = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        body: SingleChildScrollView(
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
                  "Records",
                  style: GoogleFonts.openSans(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            FutureBuilder(
                future: PrescriptionDB().readPrescriptions(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Prescription> presList = snapshot.data!;
                    presList = presList
                        .where((e) =>
                            (e.clinicID == SP.sp!.getString(SP.currClinic) &&
                                (e.doctorID == SP.sp!.getString(SP.user))))
                        .toList();
                    presList = presList
                        .where(
                            (e) => e.patientName.toLowerCase().contains(query))
                        .toList();
                    return presList.isEmpty
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
                            itemCount: presList.length,
                            itemBuilder: (context, index) {
                              Prescription pres = presList[index];
                              
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 13),
                                child: ListTile(
                                  onTap: () async {
                                    var data = await getSinglePrescription(presID: pres.prescriptionID);
                                    createPrescription(
                                        nameController: pres.patientName,
                                        ageController: pres.age,
                                        dateController: pres.createdAt.substring(0,10).split("-").reversed
                                        .join("/"),
                                        timeController: pres.createdAt.substring(11,16),
                                        phoneController: pres.phoneNumber,
                                        gender: data['gender'],
                                        vitalsResults: vitesConverter(data['vitals']),
                                        medicines: medicinefromAPIconverter(data['medicine']),
                                        tests: testsConverter(diagnosis: data['diagnosis']),
                                        diagnosis: data['diagnosis'].first['advice'].split(","));
                                  },
                                  title: Text(
                                    pres.patientName,
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text("Phone No. : "),
                                          Text(pres.phoneNumber),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Date : "),
                                          Text(pres.createdAt.substring(0,10).split("-").reversed.join("/")),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: const Icon(CupertinoIcons.doc),
                                ),
                              );
                            });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ]),
        ),
      ),
    );
  }
}
