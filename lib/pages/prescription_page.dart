import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:prescription/data/shared_preference.dart';
import 'package:prescription/data/user_database.dart';
import 'package:prescription/model/user.dart';
import 'package:printing/printing.dart';

createPrescription({
  required TextEditingController nameController,
  required TextEditingController ageController,
  required TextEditingController dateController,
  required TextEditingController timeController,
  required TextEditingController phoneController,
  required List<String> complaints,
  required String gender,
  required List<Map<String, String>> vitalsResults,
  required List<Map<String, String>> medicines,
  required List<Map<String, String>> tests,
  required List<String> diagnosis,
  required TextEditingController generalAdviceController,
  required TextEditingController referralController,
  required TextEditingController surgeryAdviceController,
}) async {
  List<DoctorData> doctorData = await UserDatabase().readDocInfo();
  DoctorData doctor = doctorData[doctorData.indexWhere((e)=>e.user == SP.sp!.getString(SP.user))];
  List clinicData = await UserDatabase().readClinicDataMap();
  var clinic = clinicData[clinicData.indexWhere((e)=> e['clinicID'] == SP.sp!.getString(SP.currClinic) )];
  // var docImage = await networkImage(clinicImage['imageURL']);
  var temp = clinic['profilePicture'].substring(0,5);
  var sign =
      (await rootBundle.load('lib/assets/signature.png')).buffer.asUint8List();
  final prescription = pw.Document();
  final fontfamily2 = await PdfGoogleFonts.latoRegular();
  prescription.addPage(pw.MultiPage(
      margin: const pw.EdgeInsets.symmetric(horizontal: 50, vertical: 40),
      pageFormat: PdfPageFormat.a4,
      theme: pw.ThemeData(
          defaultTextStyle: pw.TextStyle(
        fontSize: 14,
        font: fontfamily2,
      )),
      footer: (context) {
        return pw
            .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
            pw.Text("Clinic Name : ",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text("Cure and Care Clinic "),
          ]),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
            pw.Text("Ph : ",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Expanded(child: pw.Text("123456789/80/93")),
            pw.Text("Timings : ",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text("2 PM to 6 PM"),
          ]),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
            pw.Text("Address : ",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text("Phase 2,phase 2 ground,Jodpurpark West Bengal, 700095"),
          ])
        ]);
      },
      build: (context) {
        return [
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(children: [
                      pw.Text("Doctor : ",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 18)),
                      pw.Text("Dr. ${doctor.firstName}", style: const pw.TextStyle(fontSize: 18)),
                    ]),
                    pw.Row(children: [
                      pw.Text("Qualification : ",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 18)),
                      pw.Text(doctor.qualification, style: const pw.TextStyle(fontSize: 18)),
                    ]),
                    pw.Row(children: [
                      pw.Text("Specialisation : ",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 18)),
                      pw.Text(doctor.specialization,
                          style: const pw.TextStyle(fontSize: 18)),
                    ]),
                  ],
                ),
                pw.Container(
                  // child: pw.Image(docImage, height: 80),
                  child: pw.Text(
                    temp,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 20
                    )
                  )
                ),
              ],
            ),
            pw.Divider(
              thickness: 2,
            ),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(children: [
                          pw.Text("Patient Name : ",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text(nameController.text),
                        ]),
                        pw.Row(children: [
                          pw.Text("Patient Number : ",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text(phoneController.text),
                        ]),
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(children: [
                          pw.Text("Gender : ",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text(gender),
                        ]),
                        pw.Row(children: [
                          pw.Text("Age : ",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text(ageController.text),
                        ]),
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(children: [
                          pw.Text("Date : ",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text(
                            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                          ),
                        ]),
                        pw.Row(children: [
                          pw.Text("Time : ",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text("${TimeOfDay.now().hour}:${TimeOfDay.now().minute}"),
                        ]),
                      ])
                ]),
            pw.Divider(thickness: 2),
            pw.Text("Case History",
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 5),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Column(children: [
                    pw.Text("Complaints",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    for (int i = 0; i < complaints.length; i++)
                      pw.Text(complaints[i]),
                  ]),
                  pw.Column(children: [
                    pw.Text("Vitals",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    for (int i = 0; i < vitalsResults.length; i++)
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(vitalsResults[i]['vital'] ?? ""),
                            pw.Text(vitalsResults[i]['result'] ?? "")
                          ]),
                  ])
                ]),
            pw.Divider(),
            pw.Text("Diagnosis",
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            // pw.SizedBox(height: 5),
            for (int i = 0; i < diagnosis.length; i++) pw.Text(diagnosis[i]),
            pw.Text(diagnosis.isEmpty ? "None" : ""),
            pw.Divider(),
            pw.Text("Tests",
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            for (int i = 0; i < tests.length; i++)
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(tests[i]['name'] ?? "None"),
                    pw.Text(tests[i]['message'] ?? "")
                  ]),
            pw.Divider(),
            pw.Text("Medicines Advised",
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            // pw.SizedBox(height: 5),
            medicines[0]['dose'] == null
                ? pw.Text("None")
                : pw.Table(
                    border: pw.TableBorder.symmetric(
                      inside: const pw.BorderSide(color: PdfColors.black, width: 1.5),
                    ),
                    defaultVerticalAlignment:
                        pw.TableCellVerticalAlignment.middle,
                    children: [
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(vertical: 3),
                            child: pw.Text("Medicine Name",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(vertical: 3),
                            child: pw.Text("Dose",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(vertical: 3),
                            child: pw.Text("Frequency",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(vertical: 3),
                            child: pw.Text("Instructions",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center),
                          ),
                        ]),
                        for (int i = 0; i < medicines.length; i++)
                          pw.TableRow(children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.symmetric(vertical: 3),
                              child: pw.Text(medicines[i]['name'].toString(),
                                  textAlign: pw.TextAlign.center),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.symmetric(vertical: 3),
                              child: pw.Text(medicines[i]['dose'].toString(),
                                  textAlign: pw.TextAlign.center),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.symmetric(vertical: 3),
                              child: pw.Text(
                                  medicines[i]['frequency'].toString(),
                                  textAlign: pw.TextAlign.center),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.symmetric(vertical: 3),
                              child: pw.Text(medicines[i]['instruction'] ?? "",
                                  textAlign: pw.TextAlign.center),
                            ),
                          ])
                      ]),
            pw.Divider(),
            // General Advice
            generalAdviceController.text.isNotEmpty &&
                    (generalAdviceController.text
                            .contains(RegExp("[a-z]", caseSensitive: false)) ||
                        generalAdviceController.text.contains(RegExp("[0-9]")))
                ? pw.Text("General Advice",
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold))
                : pw.Container(),
            // pw.SizedBox(height: 5),
            generalAdviceController.text.isNotEmpty &&
                    (generalAdviceController.text
                            .contains(RegExp("[a-z]", caseSensitive: false)) ||
                        generalAdviceController.text.contains(RegExp("[0-9]")))
                ? pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                        pw.Text(generalAdviceController.text.toString()),
                        pw.Divider()
                      ])
                : pw.Container(),
            // Referrals
            referralController.text.isNotEmpty &&
                    (referralController.text
                            .contains(RegExp("[a-z]", caseSensitive: false)) ||
                        referralController.text.contains(RegExp("[0-9]")))
                ? pw.Text("Referrals",
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold))
                : pw.Container(),
            // pw.SizedBox(height: 5),
            referralController.text.isNotEmpty &&
                    (referralController.text
                            .contains(RegExp("[a-z]", caseSensitive: false)) ||
                        referralController.text.contains(RegExp("[0-9]")))
                ? pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                        pw.Text(referralController.text.toString()),
                        pw.Divider()
                      ])
                : pw.Container(),
            // Surgery Advice
            surgeryAdviceController.text.isNotEmpty &&
                    (surgeryAdviceController.text
                            .contains(RegExp("[a-z]", caseSensitive: false)) ||
                        surgeryAdviceController.text.contains(RegExp("[0-9]")))
                ? pw.Text("Surgery Advice",
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold))
                : pw.Container(),
            // pw.SizedBox(height: 5),
            surgeryAdviceController.text.isNotEmpty &&
                    (surgeryAdviceController.text
                            .contains(RegExp("[a-z]", caseSensitive: false)) ||
                        surgeryAdviceController.text.contains(RegExp("[0-9]")))
                ? pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                        pw.Text(surgeryAdviceController.text.toString()),
                        pw.Divider()
                      ])
                : pw.Container(),

            // Next visit and signature

            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Row(children: [
                    pw.Text("Next Visit : ",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text("${dateController.text} at ${timeController.text}"),
                  ]),
                  pw.Row(children: [
                    pw.Text("Signature : ",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Image(pw.MemoryImage(sign), height: 60),
                  ])
                ])
          ])
        ];
      }));

  final dir = await getTemporaryDirectory();
  const fileName = "prescription.pdf";
  final savePath = path.join(dir.path, fileName);
  final file = File(savePath);
  await file.writeAsBytes(await prescription.save());
  OpenFilex.open(file.path);
}
