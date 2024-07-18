import 'package:path/path.dart';
import 'package:prescription/model/doctor.dart';
import 'package:sqflite/sqflite.dart';

class DoctorDatabase {
  static Database? _doctorDB;

  Future<Database?> get doctorDatabase async {
    if (_doctorDB != null) {
      return _doctorDB;
    }

    String path = join(await getDatabasesPath(), 'doctorDatabase.db');
    _doctorDB =
        await openDatabase(path, version: 2, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE doctorData(
          doctorID TEXT,
          firstName TEXT,
          secondName TEXT,
          dob TEXT,
          gender TEXT,
          phoneNumber TEXT,
          email TEXT,
          qualification TEXT,
          specialization TEXT,
          personalClinic TEXT,
          collegeName TEXT,
          yearOfPassing TEXT,
          experience TEXT,
          nmcDoctorID TEXT,
          profilePicture TEXT,
          imageURL TEXT
          )
          ''');
      await db.execute('''
          CREATE TABLE clinicData(
          clinicName TEXT,
          clinicID TEXT,
          workingDays TEXT,
          startTime TEXT,
          endTime TEXT,
          doctorID TEXT
          )
          ''');
      await db.execute('''
          CREATE TABLE address(
          addressID TEXT,
          addressOne TEXT,
          city TEXT,
          country TEXT,
          doctorID TEXT,
          houseNumber TEXT,
          landmark TEXT,
          lane TEXT,
          pincode TEXT,
          state TEXT
          )
          ''');
    });
    return _doctorDB;
  }

  insertDocData(Doctor doctor ) async {
    Database? db = await doctorDatabase;
    db!.insert('doctorData', doctor.toMap());
  }
  insertClinicData(Clinic clinic ) async {
    Database? db = await doctorDatabase;
    db!.insert('clinicData', clinic.toMap());
  }
  insertAddressData(Address address ) async {
    Database? db = await doctorDatabase;
    db!.insert('address', address.toMap());
  }

  Future<List<Doctor>> readDoctorData() async {
    Database? db = await doctorDatabase;
    final list = await db!.query('doctorData');
    return list.map((map) => Doctor.fromTable(map)).toList();
  }
  Future<List<Address>> readAddress() async {
    Database? db = await doctorDatabase;
    final list = await db!.query('address');
    return list.map((map) => Address.fromTable(map)).toList();
  }
  Future<List<Clinic>> readClinic() async {
    Database? db = await doctorDatabase;
    final list = await db!.query('clinicData');
    return list.map((map) => Clinic.fromTable(map)).toList();
  }
  Future readAllData() async {
    return await Future.wait([
      readDoctorData(),
      readClinic(),
      readAddress()
    ]);}

  Future updateDoctor(
      {required String doctorID, required Map<String, Object?> data}) async {
    Database? db = await doctorDatabase;
    await db!.update(
      'doctorData',
      data,
      where: 'doctorID = ?',
      whereArgs: [doctorID],
    );
  }
}
