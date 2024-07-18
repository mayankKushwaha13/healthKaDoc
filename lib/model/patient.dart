import 'package:prescription/data/shared_preference.dart';

class Patient {
  final String id;
  final String doctorID;
  final String patientID;
  final String patientName;
  final String phoneNumber;
  final String age;
  final String gender;
  final String clinicID;
  final String created_at;
  final String createdAt;
  final String updatedAt;

  Patient({
    required this.id,
    required this.doctorID,
    required this.patientID,
    required this.patientName,
    required this.phoneNumber,
    required this.age,
    required this.gender,
    required this.clinicID,
    required this.created_at,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
        id: map['_id'],
        doctorID: map['doctor_id'] ?? SP.sp!.getString(SP.user),
        patientID: map['patient_id'],
        patientName: map['patient_name'],
        phoneNumber: map['phone_number'],
        created_at: map['created_at'],
        age: map['age'].toString(),
        gender: map['gender'],
        clinicID: map['clinic_id'] ?? SP.sp!.getString(SP.currClinic),
        createdAt: map['createdAt'],
        updatedAt: map['updatedAt']);
  }

  factory Patient.fromTable(Map<String, dynamic> map) {
    return Patient(
        id: map['id'],
        doctorID: map['doctorID'],
        patientID: map['patientID'],
        patientName: map['patientName'],
        phoneNumber: map['phoneNumber'],
        created_at: map['createdAt'],
        age: map['age'],
        gender: map['gender'],
        clinicID: map['clinicID'],
        createdAt: map['createdAt2'],
        updatedAt: map['updatedAt']);
  }

  Map<String, dynamic> toTable() {
    return {
      "id": id,
      "doctorID": doctorID,
      "patientID": patientID,
      "patientName": patientName,
      "phoneNumber": phoneNumber,
      "createdAt": created_at,
      "age": age,
      "gender": gender,
      "clinicID": clinicID,
      "createdAt2": createdAt,
      "updatedAt": updatedAt
    };
  }
}
