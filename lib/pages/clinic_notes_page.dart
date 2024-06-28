import 'package:flutter/material.dart';
import '../widgets/vitals_entry.dart';
import '../widgets/medicine_entry.dart';
import '../widgets/test_entry.dart';
import '../widgets/patient_details.dart';
import '../widgets/last_section.dart';
import '../widgets/diagnosis.dart';

class ClinicNotesPage extends StatefulWidget {
  @override
  _ClinicNotesPageState createState() => _ClinicNotesPageState();
}

class _ClinicNotesPageState extends State<ClinicNotesPage> {
  // Dropdown menu options for vitals
  List<String> vitalOptions = ['Blood Pressure', 'Pulse', 'Temperature', 'Oxygen Saturation'];

  // Dropdown menu options for medicine type, dose, duration, frequency, timing
  List<String> medicineTypes = ['Tablet', 'Capsule', 'Syrup', 'Injection'];
  List<String> doses = ['1', '2', '3', '4'];
  List<String> durations = ['1 day', '2 days', '3 days', '1 week', '2 weeks'];
  List<String> frequencies = ['Once a day', 'Twice a day', 'Thrice a day'];
  List<String> timings = ['Morning', 'Afternoon', 'Evening', 'Night'];

  List<Map<String, String>> vitalsResults = []; // List to store vitals and results
  List<Map<String, String>> medicines = []; // List to store medicines
  List<Map<String, String>> tests = []; // List to store tests

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController complaintController = TextEditingController();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescription'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.lightBlue[50],
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
              SizedBox(height: 24),
              buildSectionTitle('Enter Vitals and Results:'),
              Column(
                children: [
                  for (int index = 0; index < vitalsResults.length; index++)
                    VitalsEntry(
                      index: index,
                      vitalOptions: vitalOptions,
                      vitalsResults: vitalsResults,
                      onRemove: (i) => setState(() => vitalsResults.removeAt(i)),
                      onUpdate: (i, key, value) => setState(() => vitalsResults[i][key] = value),
                      onAdd: () => setState(() => vitalsResults.add({'vital': vitalOptions[0], 'result': ''})),
                    ),
                ],
              ),
              SizedBox(height: 24),
              DiagnosisSection(
                diagnosisController: diagnosisController,
              ),
              SizedBox(height: 24),
              buildSectionTitle('Enter Tests:'),
              Column(
                children: [
                  for (int index = 0; index < tests.length; index++)
                    TestEntry(
                      index: index,
                      tests: tests,
                      onRemove: (i) => setState(() => tests.removeAt(i)),
                      onUpdate: (i, key, value) => setState(() => tests[i][key] = value),
                      onAdd: () => setState(() => tests.add({'name': '', 'message': ''})),
                    ),
                ],
              ),
              SizedBox(height: 24),
              buildSectionTitle('Enter Medicines:'),
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
                      onRemove: (i) => setState(() => medicines.removeAt(i)),
                      onUpdate: (i, key, value) => setState(() => medicines[i][key] = value),
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
              SizedBox(height: 24),
              AdviceSection(
                generalAdviceController: generalAdviceController,
                referralController: referralController,
                surgeryAdviceController: surgeryAdviceController,
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: (){},
                  child: Text('Save Notes'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
    );
  }

}
