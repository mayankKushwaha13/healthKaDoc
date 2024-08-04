import 'dart:convert';

import 'package:prescription/constants/API%20links/prescriptionAPI.dart';
import 'package:prescription/data/prescription_database.dart';
import '../data/shared_preference.dart';
import 'package:http/http.dart' as http;

import '../model/prescription.dart';

Future getPrescription() async {
  var response = await http.post(Uri.parse("$presAPI/get_prescription_mobile"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "doctor_id": SP.sp!.getString(SP.user),
        "clinic_id": SP.sp!.getString(SP.currClinic)
      }));
  if (response.statusCode == 200){
    var body = jsonDecode(response.body.toString());
    var result = body['data'];
    List<Prescription> temp = await PrescriptionDB().readPrescriptions();
    for (int i = 0; i < result.length; i++){
      int found = temp.indexWhere((e)=>
        e.prescriptionID == result[i]['prescription_id']
      );
      if(found == -1){
        PrescriptionDB().insertData(Prescription.fromMap(result[i]));
      }
    }
  }
}

Future getSinglePrescription({required String presID}) async {
  var response = await http.post(
      Uri.parse("$presAPI/get_single_prescription_mobile"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode({
        "prescription_id": presID,
        "doctor_id": SP.sp!.getString(SP.user)
      }));
  print(response.statusCode);
  var result = jsonDecode(response.body.toString());
  var data = result['data'];
  return data;
}
