import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prescription/data/prescription_database.dart';
import 'package:prescription/functions/forPrescriptionAPI.dart';
import 'package:prescription/functions/getPrescription.dart';
import 'package:prescription/pages/prescription_page.dart';

import '../../data/shared_preference.dart';
import '../../model/prescription.dart';

class RecentVisits extends StatelessWidget {
  const RecentVisits({
    required this.name,
    required this.phone,
    super.key,
  });
  final String name;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Visits",
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    letterSpacing: -0.6,
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                        var prescription = presList.where((e)=>e.patientName == name && e.phoneNumber == phone).toList();
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: prescription.length,
                            itemBuilder: (context, index) {
                              Prescription pres = prescription[index];
                              return Card(
                                elevation: 2,
                                child: ListTile(
                                  onTap: () async {
                                    var data = await getSinglePrescription(presID: pres.prescriptionID);
                                    createPrescription(
                                        nameController: pres.patientName,
                                        ageController: pres.age,
                                        dateController: pres.createdAt.substring(0,10).split("-").reversed.join("/"),
                                        timeController: pres.createdAt.substring(11,16),
                                        phoneController: pres.phoneNumber,
                                        gender: data['gender'],
                                        vitalsResults: vitesConverter(data['vitals']),
                                        medicines: medicinefromAPIconverter(data['medicine']),
                                        tests: testsConverter(diagnosis: data['diagnosis']),
                                        diagnosis: data['diagnosis'][0]['advice'].toString().split(","),);
                                  },
                                  title: Text(
                                    pres.createdAt
                                        .substring(0, 10)
                                        .split("-")
                                        .reversed
                                        .join("/"),
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Icon(
                                    CupertinoIcons.doc,
                                    color: Colors.pink.shade600,
                                  ),
                                ),
                              );
                            });
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })
              ],
            ),
          )),
    );
  }
}
