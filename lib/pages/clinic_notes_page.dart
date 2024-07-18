import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prescription/constants/API%20links/patientAPI.dart';
import 'package:prescription/constants/API%20links/prescriptionAPI.dart';
import 'package:prescription/data/shared_preference.dart';
import 'package:prescription/functions/forPrescriptionAPI.dart';
import 'package:prescription/pages/prescription_page.dart';
import 'package:prescription/widgets/circular_design.dart';
import 'package:prescription/widgets/prescriptionWidgets/follow_up_section.dart';
import '../widgets/prescriptionWidgets/vitals_entry.dart';
import '../widgets/prescriptionWidgets/medicine_entry.dart';
import '../widgets/prescriptionWidgets/test_entry.dart';
import '../widgets/prescriptionWidgets/patient_details.dart';
import '../widgets/prescriptionWidgets/last_section.dart';
import '../widgets/prescriptionWidgets/diagnosis.dart';
import 'package:http/http.dart' as http;

class ClinicNotesPage extends StatefulWidget {
  const ClinicNotesPage({super.key});

  @override
  _ClinicNotesPageState createState() => _ClinicNotesPageState();
}

class _ClinicNotesPageState extends State<ClinicNotesPage> {
  final formKey = GlobalKey<FormState>();
  // Dropdown menu options for vitals
  List<String> vitalOptions = [
    'Blood Pressure',
    'Heart Rate',
    'Respiratory Rate',
    'Pulse Pressure',
    'Oxygen Saturation',
    'Pulse Rhythm',
    'SpO2',
    'Blood Glucose Levels',
    'Height',
    'Weight',
    'GCS',
    'Temperature',
    'Capnography',
    'Skin Color'
  ];

  // Dropdown menu options for medicine type, dose, duration, frequency, timing
  List<String> medicineTypes = [
    'Tablet',
    'Drop',
    'Injection',
    'Ointment',
    'Capsule',
    'Syrup',
    'Suspension',
    'Cream',
    'Gel',
    'Inhaler',
    'Solution',
    'Spray',
  ];
  List<String> doses = [
    for (int i = 1; i < 11; i++) i.toString(),
  ];
  List<String> durations = ['1 day', '2 days', '3 days', '1 week', '2 weeks'];
  List<String> frequencies = [
    '1-1-1',
    '1-1-0',
    '1-0-1',
    '1-0-0',
    '0-1-1',
    '0-1-0',
    '0-0-1',
    '4-T',
    'Q-1-H',
    'Q-2-H',
    'Q-3-H',
    'Q-4-H',
    'Q-6-H',
    'Q-8-H',
    'Q-12-H',
    'SOS'
  ];
  List<String> timings = ['After Meal', 'Before Meal', 'Fasting'];

  List<Map<String, String>> vitalsResults =
      []; // List to store vitals and results
  List<Map<String, String>> medicines = []; // List to store medicines
  List<Map<String, String>> tests = []; // List to store tests

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController complaintController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  String gender = 'Male';
  final TextEditingController generalAdviceController = TextEditingController();
  final TextEditingController referralController = TextEditingController();
  final TextEditingController surgeryAdviceController = TextEditingController();
  final TextEditingController diagnosisController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with one default entry for vitals and results
    vitalsResults.add({});
    // Initialize with one default entry for medicine
    medicines.add({});
    // Initialize with one default entry for tests
    tests.add({});
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 221, 233),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
            predictions.clear();
            predictions2.clear();
            diagnosis.clear();
          },
          child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                DecorationPrescription(width: width),
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: width,
                          height: 100,
                          alignment: Alignment.bottomCenter,
                          decoration: const BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40))),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              "Prescription",
                              style: GoogleFonts.aBeeZee(
                                fontSize: 28,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          transform:
                              Matrix4.translationValues(-width / 2 + 30, 0, 0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              child: Icon(
                                CupertinoIcons.back,
                                color: Colors.pink,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Colors.indigo.shade50,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: PatientDetails(
                                  nameController: nameController,
                                  ageController: ageController,
                                  phoneController: phoneController,
                                  complaintController: complaintController,
                                  gender: gender,
                                  onGenderChanged: (newValue) {
                                    setState(() {
                                      gender = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  buildSectionTitle('Enter Vitals and Results:'),
                                  IconButton(
                                      onPressed: () {
                                        setState(() => vitalsResults.add({
                                              'vital': vitalOptions[0],
                                              'result': ''
                                            }));
                                      },
                                      icon: const CircleAvatar(
                                        backgroundColor: Colors.indigo,
                                        child: Icon(
                                          CupertinoIcons.add,
                                          color: Colors.white,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                for (int index = 0;
                                    index < vitalsResults.length;
                                    index++)
                                  VitalsEntry(
                                    index: index,
                                    vitalOptions: vitalOptions,
                                    vitalsResults: vitalsResults,
                                    onRemove: (i) =>
                                        setState(() => vitalsResults.removeAt(i)),
                                    onUpdate: (i, key, value) => setState(
                                        () => vitalsResults[i][key] = value),
                                    onAdd: () => setState(() => vitalsResults
                                            .add({
                                          'vital': vitalOptions[0],
                                          'result': ''
                                        })),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            DiagnosisSection(
                              diagnosisController: diagnosisController,
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  buildSectionTitle('Enter Tests:'),
                                  IconButton(
                                      onPressed: () {
                                        setState(() => tests
                                            .add({'name': "", 'message': ''}));
                                      },
                                      icon: const CircleAvatar(
                                        backgroundColor: Colors.indigo,
                                        child: Icon(
                                          CupertinoIcons.add,
                                          color: Colors.white,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                for (int index = 0; index < tests.length; index++)
                                  TestEntry(
                                    index: index,
                                    tests: tests,
                                    onRemove: (i) =>
                                        setState(() => tests.removeAt(i)),
                                    onUpdate: (i, key, value) =>
                                        setState(() => tests[i][key] = value),
                                    onAdd: () => setState(() =>
                                        tests.add({'name': '', 'message': ''})),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  buildSectionTitle('Enter Medicines:'),
                                  IconButton(
                                      onPressed: () {
                                        setState(() => medicines.add({
                                              'name': '',
                                              'instructions': '',
                                              'type': medicineTypes[0],
                                              'dose': doses[0],
                                              'duration': durations[0],
                                              'frequency': frequencies[0],
                                              'timing': timings[0],
                                            }));
                                      },
                                      icon: const CircleAvatar(
                                        backgroundColor: Colors.indigo,
                                        child: Icon(
                                          CupertinoIcons.add,
                                          color: Colors.white,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                for (int index = 0;
                                    index < medicines.length;
                                    index++)
                                  MedicineEntry(
                                    index: index,
                                    medicineTypes: medicineTypes,
                                    doses: doses,
                                    durations: durations,
                                    frequencies: frequencies,
                                    timings: timings,
                                    medicines: medicines,
                                    onRemove: (i) =>
                                        setState(() => medicines.removeAt(i)),
                                    onUpdate: (i, key, value) =>
                                        setState(() => medicines[i][key] = value),
                                    onAdd: () => setState(() => medicines.add({
                                          'name': '',
                                          'instructions': '',
                                          'type': medicineTypes[0],
                                          'dose': doses[0],
                                          'duration': durations[0],
                                          'frequency': frequencies[0],
                                          'timing': timings[0],
                                        })),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            buildSectionTitle("Follow Up:"),
                            FollowUpSection(
                              dateController: dateController,
                              timeController: timeController,
                            ),
                            const SizedBox(height: 24),
                            AdviceSection(
                              generalAdviceController: generalAdviceController,
                              referralController: referralController,
                              surgeryAdviceController: surgeryAdviceController,
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: Ink(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.blue.shade700),
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () async {
                                      if(formKey.currentState!.validate()){PermissionStatus storageStatus =
                                          await Permission.storage.request();
                                      if (storageStatus ==
                                          PermissionStatus.permanentlyDenied) {
                                        openAppSettings();
                                      }
                                      prescriptionAPI();
                                      createPrescription(
                                        dateController: dateController,
                                        timeController: timeController,
                                        nameController: nameController,
                                        ageController: ageController,
                                        phoneController: phoneController,
                                        complaints: complaintsList,
                                        gender: gender,
                                        vitalsResults: vitalsResults,
                                        medicines: medicines,
                                        tests: tests,
                                        diagnosis: diagnosisList,
                                        generalAdviceController:
                                            generalAdviceController,
                                        referralController: referralController,
                                        surgeryAdviceController:
                                            surgeryAdviceController,
                                      );}
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10),
                                      child: Text(
                                        'Save',
                                        style: GoogleFonts.aBeeZee(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: sqrt1_2),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.red.shade700),
    );
  }

  prescriptionAPI() async {
    Map<String, dynamic> body = {
      "patient_name": nameController.text,
      "age": ageController.text,
      "phone_number": phoneController.text,
      "gender": gender,
      "doctor_id": SP.sp!.getString(SP.user),
      "clinic_id": SP.sp!.getString(SP.currClinic),
      "vitals": vitalsConverter(vitalsResults),
      "diagnosis": diagnosisConverter(tests: tests, diagnosisList: diagnosisList),
      "medicine": medicineConverter(medicines),
      "follow_up": dateController.text.isNotEmpty || timeController.text.isNotEmpty ? true : false,
      "follow_up_date": dateController.text,
      "follow_up_time": timeController.text
    };
    print(1);
    var response = await http.post(
      Uri.parse("${presAPI}/create_prescription_mobile"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(body),
    );
    print(2);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    ageController.dispose();
    phoneController.dispose();
    complaintController.dispose();
    dateController.dispose();
    timeController.dispose();
    generalAdviceController.dispose();
    referralController.dispose();
    surgeryAdviceController.dispose();
    diagnosisController.dispose();
    complaintsList.clear();
    diagnosisList.clear();
    predictions.clear();
    predictions2.clear();
    diagnosis.clear();
    super.dispose();
  }
}

class DecorationPrescription extends StatelessWidget {
  const DecorationPrescription({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        CircularDesign(
          radius: 200,
          color: Colors.indigo,
          x: width / 2,
          y: 500,
        ),
        CircularDesign(
          radius: 150,
          color: Colors.indigo,
          x: width / 2,
          y: 600,
        ),
        CircularDesign(
          radius: 200,
          color: Colors.indigo,
          x: -width / 2,
          y: 500,
        ),
        CircularDesign(
          radius: 150,
          color: Colors.indigo,
          x: -width / 2,
          y: 600,
        ),
        CircularDesign(
          radius: 200,
          color: Colors.indigo,
          x: width / 2,
          y: 1450,
        ),
        CircularDesign(
          radius: 150,
          color: Colors.indigo,
          x: width / 2,
          y: 1550,
        ),
        CircularDesign(
          radius: 200,
          color: Colors.indigo,
          x: -width / 2,
          y: 1450,
        ),
        CircularDesign(
          radius: 150,
          color: Colors.indigo,
          x: -width / 2,
          y: 1550,
        ),
        CircularDesign(
          radius: 200,
          color: Colors.indigo,
          x: -width / 2,
          y: 2600,
        ),
        CircularDesign(
          radius: 150,
          color: Colors.indigo,
          x: -width / 2,
          y: 2700,
        ),
        CircularDesign(
          radius: 200,
          color: Colors.indigo,
          x: width / 2,
          y: 2600,
        ),
        CircularDesign(
          radius: 150,
          color: Colors.indigo,
          x: width / 2,
          y: 2700,
        ),
      ],
    );
  }
}
