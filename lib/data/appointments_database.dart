import 'package:path/path.dart';
import 'package:prescription/model/appointment.dart';
import 'package:sqflite/sqflite.dart';

class AppointmentsDB {
  static Database? _appointmentDB;

  Future<Database?> get appointmentDatabase async {
    if (_appointmentDB != null) {
      return _appointmentDB;
    }

    String path = join(await getDatabasesPath(), 'appointmentDatabase.db');
    _appointmentDB =
        await openDatabase(path, version: 2, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE appointments(
          patientID TEXT,
          doctorID TEXT,
          patientName TEXT,
          age TEXT,
          gender TEXT,
          clinicID TEXT,
          appointmentType TEXT,
          appointmentDate TEXT,
          appointmentTime TEXT
          )
          ''');
    });
    return _appointmentDB;
  }

  insertData(Appointment appointment) async {
    Database? db = await appointmentDatabase;
    db!.insert('appointments', appointment.toTable());
  }

  Future<List<Appointment>> readAppointments() async {
    Database? db = await appointmentDatabase;
    final list = await db!.query('appointments');
    return list.map((map) => Appointment.fromTable(map)).toList();
  }

  // Future updateData(
  //     {
  //     required String patientID,
  //     required Map<String, Object?> data}) async {
  //   Database? db = await appointmentDatabase;
  //   await db!.update(
  //     'patientInfo',
  //     data,
  //     where: 'patientID = ?',
  //     whereArgs: [patientID],
  //   );
  // }
}
