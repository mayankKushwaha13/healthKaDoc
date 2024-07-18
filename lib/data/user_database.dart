import 'package:path/path.dart';
import 'package:prescription/model/user.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabase {
  static Database? _userDB;

  Future<Database?> get database async {
    if (_userDB != null) {
      return _userDB;
    }
    String path = join(await getDatabasesPath(), 'userDatabase.db');
    _userDB = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE doctorInfo(
          user TEXT,
          firstName TEXT,
          secondName TEXT,
          email TEXT,
          phoneNumber TEXT,
          qualification TEXT,
          specialization TEXT
          )
          ''');
        await db.execute('''
          CREATE TABLE clinicAddress(
          addressID TEXT,
          houseNumber TEXT,
          lane TEXT,
          addressOne TEXT,
          landmark TEXT,
          city TEXT,
          state TEXT,
          pincode TEXT,
          country TEXT,
          clinicID TEXT
          )
          ''');
        await db.execute('''
          CREATE TABLE clinicData(
          user TEXT,
          clinicID TEXT,
          clinicName TEXT,
          clinicPhoneNumber TEXT,
          workingDays TEXT,
          startTime TEXT,
          endTime TEXT,
          profilePicture TEXT,
          imageURL TEXT
          )
          ''');
        await db.execute('''
          CREATE TABLE clinicNameWithID(
          user TEXT,
          clinicName TEXT,
          clinicID TEXT
          )
          ''');
      },
    );
    return _userDB!;
  }

  insertData(
    User user,
  ) async {
    Database? db = await database;
    db!.insert('doctorInfo', user.toDoctorInfo());
    print("addeddocinfo");
    db.insert('clinicAddress', user.toClinicAddress());
    print('addedclinicadd');
    db.insert('clinicData', user.toClinicData());
    print("addedclinicdata");

    for (int i = 0; i < user.clinicNameWithID.length; i++) {
      Map<String, String> map = {
        'user': user.user,
        'clinicName': user.clinicNameWithID[i]['clinic_name'].toString(),
        'clinicID': user.clinicNameWithID[i]['clinic_id'].toString()
      };
      db.insert('clinicNameWithID', map);
    }
  }

  insertClinicData(ClinicData clinic) async {
    Database? db = await database;
    db!.insert('clinicData', clinic.toMap());
  }

  Future<List<DoctorData>> readDocInfo() async {
    Database? db = await database;
    final list = await db!.query('doctorInfo');
    print("fetchComplete");
    return list.map((map) => DoctorData.fromTable(map)).toList();
  }

  Future<List<ClinicAddress>> readClinicAdd() async {
    Database? db = await database;
    final list = await db!.query('clinicAddress');
    print("fetchComplete");
    return list.map((map) => ClinicAddress.fromTable(map)).toList();
  }

  Future<List<ClinicData>> readClinicData() async {
    Database? db = await database;
    final list = await db!.query('clinicData');
    print("fetchComplete");
    return list.map((map) => ClinicData.fromTable(map)).toList();
  }

  Future<List> readClinicDataMap() async {
    Database? db = await database;
    final list = await db!.query('clinicData');
    return list;
  }

  Future<List<ClinicNameWithID>> readClinicNameWithID() async {
    Database? db = await database;
    final list = await db!.query('clinicNameWithID');
    print("fetchComplete");
    return list.map((map) => ClinicNameWithID.fromMap(map)).toList();
  }

  Future readAllData() async {
    return await Future.wait([
      readDocInfo(),
      readClinicAdd(),
      readClinicData(),
      readClinicNameWithID()
    ]);
  }

  Future updateData(
      {
      required String whereArgs,
      required String table,
      required Map<String, Object?> data}) async {
    Database? db = await database;
    await db!.update(
      table,
      data,
      where: 'user = ?',
      whereArgs: [whereArgs],
    );
  }

  Future updateClinicID(
      {
      required String user,
      required String clinicName,
      required String clinicID,}) async {
    Database? db = await database;
    await db!.update(
      'clinicData',
      {
        "clinicID" : clinicID
      },
      where: 'user = ? AND clinicName = ?',
      whereArgs: [user, clinicName],
    );
  }

  // void alterTable() async {
  //   Database? db = await database;
  //   await db!.execute("Alter table clinicData Add clinicID TEXT");
  //   print("done");
  // }
}
