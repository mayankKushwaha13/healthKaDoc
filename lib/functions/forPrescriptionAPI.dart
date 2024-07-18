List<Map<String, dynamic>> vitalsConverter(List<Map<String, String>> map) {
  List<Map<String, dynamic>> vitals = [];
  map.forEach((e) {
    vitals.add({
      'vites_name': e['vital'],
      'vite_result': e['result'],
    });
  });
  return vitals;
}

List<Map<String, dynamic>> diagnosisConverter(
    {required List<Map<String, String>> tests,
    required List<String> diagnosisList}) {
  List<Map<String, dynamic>> diagnosis = [];
  diagnosis.add({
    "advice" : diagnosisList.join(", "), 
  });
  tests.forEach((e){
    diagnosis.add({
      'test_name' : e['name'],
      'advice' : e['message']
    });
  });

  return diagnosis;
}

List<Map<String, dynamic>> medicineConverter(List<Map<String, String>> map){
  List<Map<String, dynamic>> medicines = [];
  map.forEach((e){
    medicines.add({
      'medicine_name' : e['name'],
      'medicine_type' : e['type'],
      'dose' : e['dose'],
      'duration' : e['duration'],
      'time' : "${e['timing']}, ${e['frequency']}",
      'advice' : e['instructions']
    }
    );
  });

  return medicines;
}
