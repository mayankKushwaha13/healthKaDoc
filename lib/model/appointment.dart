import 'package:prescription/data/shared_preference.dart';

class Appointment {
  final String doctorID;
  final String patientID;
  final String patientName;
  final String age;
  final String gender;
  final String clinicID;
  final String appointmentType;
  final String appointmentDate;
  final String appointmentTime;

  Appointment({
    required this.doctorID,
    required this.patientID,
    required this.patientName,
    required this.age,
    required this.gender,
    required this.clinicID,
    required this.appointmentType,
    required this.appointmentDate,
    required this.appointmentTime,
  });

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
        doctorID: SP.sp!.getString(SP.user)!,
        patientID: map['patient_id'],
        patientName: map['patient_name'],
        age: map['age'].toString(),
        gender: map['gender'],
        clinicID: SP.sp!.getString(SP.currClinic)!,
        appointmentDate: map['appointment_date'] ?? "25/07/2024",
        appointmentTime: map['appointment_time'],
        appointmentType: map['appointment_type'].toString()
    );
  }

  factory Appointment.fromTable(Map<String, dynamic> map) {
    return Appointment(
        doctorID: map['doctorID'],
        patientID: map['patientID'],
        patientName: map['patientName'],
        age: map['age'],
        gender: map['gender'],
        clinicID: map['clinicID'],
        appointmentDate: map['appointmentDate'],
        appointmentTime: map['appointmentTime'],
        appointmentType: map['appointmentType'],
      );
  }

  Map<String, dynamic> toTable() {
    return {
      "doctorID": doctorID,
      "patientID": patientID,
      "patientName": patientName,
      "age": age,
      "gender": gender,
      "clinicID": clinicID,
      "appointmentType" : appointmentType,
      "appointmentDate" : appointmentDate,
      "appointmentTime" : appointmentTime,
    };
    
  }
}
