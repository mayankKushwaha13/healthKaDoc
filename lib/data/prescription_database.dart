import 'package:path/path.dart';
import 'package:prescription/model/prescription.dart';
import 'package:sqflite/sqflite.dart';

class PrescriptionDB {
  static Database? _prescriptionDB;

  Future<Database?> get prescriptionDatabase async {
    if (_prescriptionDB != null) {
      return _prescriptionDB;
    }

    String path = join(await getDatabasesPath(), 'prescriptionDatabase.db');
    _prescriptionDB =
        await openDatabase(path, version: 2, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE prescriptions(
          patientID TEXT,
          doctorID TEXT,
          patientName TEXT,
          age TEXT,
          clinicID TEXT,
          phoneNumber TEXT,
          createdAt TEXT,
          prescriptionID TEXT
          )
          ''');
    });
    return _prescriptionDB;
  }

  insertData(Prescription prescription) async {
    Database? db = await prescriptionDatabase;
    db!.insert('prescriptions', prescription.toTable());
  }

  Future<List<Prescription>> readPrescriptions() async {
    Database? db = await prescriptionDatabase;
    final list = await db!.query('prescriptions');
    return list.map((map) => Prescription.fromTable(map)).toList();
  }

  // Future updateData(
  //     {
  //     required String patientID,
  //     required Map<String, Object?> data}) async {
  //   Database? db = await prescriptionDatabase;
  //   await db!.update(
  //     'patientInfo',
  //     data,
  //     where: 'patientID = ?',
  //     whereArgs: [patientID],
  //   );
  // }
}
