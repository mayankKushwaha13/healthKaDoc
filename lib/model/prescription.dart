import 'package:prescription/data/shared_preference.dart';

class Prescription {
  final String doctorID;
  final String patientID;
  final String patientName;
  final String age;
  final String clinicID;
  final String phoneNumber;
  final String prescriptionID;
  final String createdAt;

  Prescription({
    required this.doctorID,
    required this.patientID,
    required this.patientName,
    required this.age,
    required this.clinicID,
    required this.createdAt,
    required this.phoneNumber,
    required this.prescriptionID,
  });

  factory Prescription.fromMap(Map<String, dynamic> map) {
    return Prescription(
        doctorID: SP.sp!.getString(SP.user)!,
        patientID: map['patient_id'],
        patientName: map['patient_name'],
        age: map['age'].toString(),
        clinicID: SP.sp!.getString(SP.currClinic)!,
        createdAt: map['createdAt'],
        phoneNumber: map['phone_number'],
        prescriptionID: map['prescription_id']
    );
  }

  factory Prescription.fromTable(Map<String, dynamic> map) {
    return Prescription(
        doctorID: map['doctorID'],
        patientID: map['patientID'],
        patientName: map['patientName'],
        age: map['age'],
        clinicID: map['clinicID'],
        createdAt: map['createdAt'],
        phoneNumber: map['phoneNumber'],
        prescriptionID: map['prescriptionID']
      );
  }

  Map<String, dynamic> toTable() {
    return {
      "doctorID": doctorID,
      "patientID": patientID,
      "patientName": patientName,
      "age": age,
      "clinicID": clinicID,
      "prescriptionID" : prescriptionID,
      "createdAt" : createdAt,
      "phoneNumber" : phoneNumber
    };
    
  }
}
