import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prescription/widgets/circular_design.dart';
import 'package:prescription/widgets/prescriptionWidgets/follow_up_section.dart';
import '../widgets/prescriptionWidgets/vitals_entry.dart';
import '../widgets/prescriptionWidgets/medicine_entry.dart';
import '../widgets/prescriptionWidgets/test_entry.dart';
import '../widgets/prescriptionWidgets/patient_details.dart';
import '../widgets/prescriptionWidgets/last_section.dart';
import '../widgets/prescriptionWidgets/diagnosis.dart';

class ClinicNotesPage extends StatefulWidget {
  const ClinicNotesPage({super.key});

  @override
  _ClinicNotesPageState createState() => _ClinicNotesPageState();
}

class _ClinicNotesPageState extends State<ClinicNotesPage> {
  // Dropdown menu options for vitals
  List<String> vitalOptions = [
    'Blood Pressure',
    'Pulse',
    'Temperature',
    'Oxygen Saturation'
  ];

  // Dropdown menu options for medicine type, dose, duration, frequency, timing
  List<String> medicineTypes = ['Tablet', 'Capsule', 'Syrup', 'Injection'];
  List<String> doses = ['1', '2', '3', '4'];
  List<String> durations = ['1 day', '2 days', '3 days', '1 week', '2 weeks'];
  List<String> frequencies = ['Once a day', 'Twice a day', 'Thrice a day'];
  List<String> timings = ['Morning', 'Afternoon', 'Evening', 'Night'];

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
    vitalsResults.add({'vital': vitalOptions[0], 'result': ''});
    // Initialize with one default entry for medicine
    medicines.add({
      'name': '',
      'instructions': '',
      'type': medicineTypes[0],
      'dose': doses[0],
      'duration': durations[0],
      'frequency': frequencies[0],
      'timing': timings[0],
    });
    // Initialize with one default entry for tests
    tests.add({'name': '', 'message': ''});
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
                    Padding(
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
                                  onUpdate: (i, key, value) =>
                                      setState(() => vitalsResults[i][key] = value),
                                  onAdd: () => setState(() => vitalsResults.add(
                                      {'vital': vitalOptions[0], 'result': ''})),
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
                                      setState(() =>
                                          tests.add({'name': "", 'message': ''}));
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
                                  onAdd: () => setState(
                                      () => tests.add({'name': '', 'message': ''})),
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
                              for (int index = 0; index < medicines.length; index++)
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
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
        CircularDesign(radius: 200, color: Colors.indigo, x: width/2,y: 500,),
        CircularDesign(radius: 150, color: Colors.indigo, x: width/2,y: 600,),
        CircularDesign(radius: 200, color: Colors.indigo, x: -width/2,y: 500,),
        CircularDesign(radius: 150, color: Colors.indigo, x: -width/2,y: 600,),
        CircularDesign(radius: 200, color: Colors.indigo, x: width/2,y: 1450,),
        CircularDesign(radius: 150, color: Colors.indigo, x: width/2,y: 1550,),
        CircularDesign(radius: 200, color: Colors.indigo, x: -width/2,y: 1450,),
        CircularDesign(radius: 150, color: Colors.indigo, x: -width/2,y: 1550,),
        CircularDesign(radius: 200, color: Colors.indigo, x: -width/2,y: 2600,),
        CircularDesign(radius: 150, color: Colors.indigo, x: -width/2,y: 2700,),
        CircularDesign(radius: 200, color: Colors.indigo, x: width/2,y: 2600,),
        CircularDesign(radius: 150, color: Colors.indigo, x: width/2,y: 2700,),
      ],
    );
  }
}
