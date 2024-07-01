import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrescriptionDisplayScreen extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController ageController;
  final TextEditingController phoneController;
  final TextEditingController complaintController;
  final String gender;
  final List<Map<String, String>> vitalsResults;
  final List<Map<String, String>> medicines;
  final List<Map<String, String>> tests;
  final TextEditingController diagnosisController;
  final TextEditingController generalAdviceController;
  final TextEditingController referralController;
  final TextEditingController surgeryAdviceController;

  PrescriptionDisplayScreen({
    required this.nameController,
    required this.ageController,
    required this.phoneController,
    required this.complaintController,
    required this.gender,
    required this.vitalsResults,
    required this.medicines,
    required this.tests,
    required this.diagnosisController,
    required this.generalAdviceController,
    required this.referralController,
    required this.surgeryAdviceController,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlue[50],
        body: Card(
          margin: EdgeInsets.all(20),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.teal,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "Doctor: ",
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: "Dr. ABC",
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "Qualification: ",
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: "MD",
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "Specialisation: ",
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: "Cardiology",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          'assets/doctor3.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.teal,
                    thickness: 1,
                  ),
                  Wrap(
                    runAlignment: WrapAlignment.spaceBetween,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      SizedBox(width: double.infinity,),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Name: ",
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: nameController.text,
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Phone No.: ",
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: phoneController.text,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Age: ",
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ageController.text,
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Gender: ",
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: gender,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Divider(
                    color: Colors.teal,
                    thickness: 1,
                  ),
                  Center(
                    child: Text(
                      "Prescription",
                      style: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.teal,
                    thickness: 2,
                  ),
                  SizedBox(height: 20,),

                  buildSectionTitle('Case History'),
                  buildSubSectionTitle('Vitals:'),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: vitalsResults.length,
                    itemBuilder: (context, index) {
                      final vital = vitalsResults[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${vital['vital']}:',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            vital['result'] ?? '',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 20,),
                  buildSubSectionTitle('Complaints:'),
                  buildDetailRow(complaintController.text),
                  SizedBox(height: 20,),

                  Divider(
                    color: Colors.teal,
                    thickness: 1,
                  ),
                  buildSectionTitle('Medicines'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Medicine Name",
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Dose",
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Frequency",
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Instructions",
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: medicines.length,
                    itemBuilder: (context, index) {
                      final medicine = medicines[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              medicine['name'] ?? '',
                              style: GoogleFonts.lato(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              medicine['dose'] ?? '',
                              style: GoogleFonts.lato(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              medicine['frequency'] ?? '',
                              style: GoogleFonts.lato(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              medicine['instructions'] ?? '',
                              style: GoogleFonts.lato(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20,),

                  Divider(
                    color: Colors.teal,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Signature: __________________",
                        style: GoogleFonts.lato(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.teal,
      ),
    );
  }

  Widget buildSubSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.lato(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.teal[700],
      ),
    );
  }

  Widget buildDetailRow(String detail) {
    return Text(
      detail,
      style: GoogleFonts.lato(
        fontSize: 16,
      ),
    );
  }
}
