List<Map<String, dynamic>> vitalsConverter(List<Map<String, String>> map) {
  List<Map<String, dynamic>> vitals = [];
  for (var e in map) {
    vitals.add({
      'vites_name': e['vital'],
      'vite_result': e['result'],
    });
  }
  return vitals;
}

List<Map<String, String>> vitesConverter(List<dynamic> map) {
  List<Map<String, String>> vitals = [];
  for (var e in map) {
    vitals.add({
      'vital': e['vites_name'].toString(),
      'result': e['vite_result'].toString(),
    });
  }
  return vitals;
}

List<Map<String, dynamic>>? diagnosisConverter(
    {required List<Map<String, String>> tests,
    required List<String> diagnosisList}) {
  List<Map<String, dynamic>> diagnosis = [];
  diagnosis.add({
    "advice" : diagnosisList.join(", "), 
  });
  for (var e in tests) {
    diagnosis.add({
      'test_name' : e['name'],
      'advice' : e['message']
    });
  }

  return diagnosis;
}

List<Map<String, String>> testsConverter(
    {required List<dynamic> diagnosis,}) {
  List<Map<String, String>> tests = [];
  diagnosis.removeAt(0);
  for (var e in diagnosis) {
    tests.add({
      'name' : e['test_name'],
      'message' : e['advice']
    });
  }

  return tests;
}

List<Map<String, dynamic>> medicineConverter(List<Map<String, String>> map){
  List<Map<String, dynamic>> medicines = [];
  for (var e in map) {
    medicines.add({
      'medicine_name' : e['name'].toString(),
      'medicine_type' : e['type'].toString(),
      'dose' : e['dose'].toString(),
      'duration' : e['duration'].toString(),
      'time' : "${e['timing'].toString()}, ${e['frequency'].toString()}",
      'advice' : e['instructions'].toString()
    }
    );
  }

  return medicines;
}

List<Map<String, String>> medicinefromAPIconverter(List<dynamic> map){
  List<Map<String, String>> medicines = [];
  for (var e in map) {
    var time = e['time']?.split(',');
    medicines.add({
      'name' : e['medicine_name'].toString(),
      'type' : e['medicine_type'].toString(),
      'dose' : e['dose'].toString(),
      'duration' : e['duration'].toString(),
      'timing' :time![0],
      'frequency' : time![1],
      'instructions' : e['advice'].toString()
    }
    );
  }

  return medicines;
}

