import 'dart:convert';

import '../constants/API links/appointmentsAPI.dart';
import '../data/appointments_database.dart';
import '../data/shared_preference.dart';
import '../model/appointment.dart';
import 'package:http/http.dart' as http;

getAppointments() async {
  List<Appointment> apptList = await AppointmentsDB().readAppointments();
  apptList = apptList
      .where((e) =>
          e.doctorID == SP.sp!.getString(SP.user) &&
          e.clinicID == SP.sp!.getString(SP.currClinic))
      .toList();
  var response = await http.post(
      Uri.parse("${apptAPI}/get_all_appointments_mobile"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode({
        "doctor_id": SP.sp!.getString(SP.user),
        "clinic_id": SP.sp!.getString(SP.currClinic)
      }));
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body.toString());
    var result = body['result'];
    if (result.length != apptList.length) {
      var list = await AppointmentsDB().readAppointments();

      for (int i = 0; i < result.length; i++) {
        Appointment apt = Appointment.fromMap(result[i]);
        int found = list.indexWhere((e) => e.patientName == apt.patientName);
        if (found == -1) {
          AppointmentsDB().insertData(apt);
        }
      }
    }
  }
}
