import 'package:path/path.dart';
import 'package:prescription/model/patient.dart';
import 'package:sqflite/sqflite.dart';

class PatientDatabase {
  static Database? _patientDB;

  Future<Database?> get patientDatabase async {
    if (_patientDB != null) {
      return _patientDB;
    }

    String path = join(await getDatabasesPath(), 'patientDatabase.db');
    _patientDB =
        await openDatabase(path, version: 2, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE patientInfo(
          id TEXT,
          doctorID TEXT,
          patientID TEXT,
          patientName TEXT,
          phoneNumber TEXT,
          createdAt TEXT,
          age TEXT,
          gender TEXT,
          clinicID TEXT,
          createdAt2 TEXT,
          updatedAt TEXT
          )
          ''');
    });
    return _patientDB;
  }

  insertData(Patient patient) async {
    Database? db = await patientDatabase;
    db!.insert('patientInfo', patient.toTable());
  }

  Future<List<Patient>> readPatientData() async {
    Database? db = await patientDatabase;
    final list = await db!.query('patientInfo');
    return list.map((map) => Patient.fromTable(map)).toList();
  }

  Future updateData(
      {
      required String patientID,
      required Map<String, Object?> data}) async {
    Database? db = await patientDatabase;
    await db!.update(
      'patientInfo',
      data,
      where: 'patientID = ?',
      whereArgs: [patientID],
    );
  }
}
