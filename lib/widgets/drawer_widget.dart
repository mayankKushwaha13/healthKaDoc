import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prescription/constants/API%20links/doctorAPI.dart';
import 'package:prescription/data/shared_preference.dart';
import 'package:prescription/data/user_database.dart';
import 'package:prescription/model/user.dart';
import 'package:prescription/pages/clinic_notes_page.dart';
import 'package:prescription/pages/home_page.dart';
import 'package:prescription/pages/login_page.dart';
import 'package:http/http.dart' as http;

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  List clinicData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addClinicData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue.shade100,
      shadowColor: Colors.blue,
      elevation: 200,
      child: Column(
        children: [
          Container(
            height: 200,
            child: DrawerHeader(
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Image.asset("lib/assets/nexus.png"),
            ),
          ),
          const Divider(
            thickness: 2,
            color: Colors.white,
          ),
          ListTile(
            tileColor: Colors.blue.shade900,
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => route.isCurrent);
            },
            leading: Image.asset(
              "lib/assets/clinic.png",
              height: 24,
            ),
            title: Text(
              "Home",
              style: GoogleFonts.openSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          ListTile(
            tileColor: Colors.blue.shade900,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ClinicNotesPage()));
            },
            leading: Image.asset(
              "lib/assets/prescription.png",
              height: 24,
            ),
            title: Text(
              "Add Prescription",
              style: GoogleFonts.openSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          ListTile(
            tileColor: Colors.blue.shade700,
            leading: Image.asset(
              "lib/assets/clinic.png",
              height: 24,
            ),
            title: Text(
              "Clinics : ",
              style: GoogleFonts.openSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: FutureBuilder(
                future: UserDatabase().readClinicDataMap(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    clinicData = snapshot.data!;
                    clinicData = clinicData
                        .where((e) => e['user'] == SP.sp!.getString(SP.user))
                        .toList();
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: clinicData.length,
                      itemBuilder: (context, index) {
                        var clinic = clinicData[index];
                        return Card(
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                SP.sp!.setString(
                                    SP.currClinic, clinic['clinicID']);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "${clinic['clinicName']} clinic selected")));
                                Scaffold.of(context).closeDrawer();
                              });
                            },
                            titleAlignment: ListTileTitleAlignment.center,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            tileColor: Colors.pink.shade700,
                            contentPadding:
                                EdgeInsets.only(top: 10, bottom: 10, left: 20),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10000),
                              // child: Image.network(
                              //   clinic['imageURL'],
                              // )
                              child: Text(
                                clinic['profilePicture'].substring(0, 5),
                                style: GoogleFonts.lato(color: Colors.white),
                              ),
                            ),
                            subtitle: Text(
                              clinic['clinicID'],
                              style: GoogleFonts.lato(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white54),
                            ),
                            title: Text(
                              clinic['clinicName'],
                              style: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        );
                      });
                }),
          ),
          const Expanded(child: SizedBox()),
          ListTile(
            tileColor: Colors.blue.shade900,
            leading: Icon(
              Icons.logout_rounded,
              color: Colors.red.shade300,
            ),
            title: Text(
              "Logout",
              style: GoogleFonts.aBeeZee(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            onTap: () async {
              SP.sp!.setBool(SP.login, false);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          )
        ],
      ),
    );
  }

  addClinicData() async {
    List temp = await UserDatabase().readClinicDataMap();
    temp = temp.where((e) => e['user'] == SP.sp!.getString(SP.user)).toList();
    List<ClinicNameWithID> clinics =
        await UserDatabase().readClinicNameWithID();
    clinics =
        clinics.where((e) => e.user == SP.sp!.getString(SP.user)).toList();
    for (int i = 0; i < temp.length; i++) {
      var clinicID = clinics[clinics.indexWhere((e)=>e.clinicName == temp[i]['clinicName'])].clinicID;
      UserDatabase().updateClinicID(
            user: SP.sp!.getString(SP.user)!,
            clinicName: temp[i]['clinicName'],
            clinicID: clinicID);
    }
    for (int i = 0; i < temp.length; i++) {
      if (temp[i]['clinicID'] == null) {
        var ID = clinics[clinics
                .indexWhere((e) => e.clinicName == temp[i]['clinicName'])]
            .clinicID;
        UserDatabase().updateClinicID(
            user: SP.sp!.getString(SP.user)!,
            clinicName: temp[i]['clinicName'],
            clinicID: ID);
      }
    }
    if (temp.length == clinics.length) {
      clinicData = temp;
      return;
    }
    print("here");
    for (int i = 0; i < clinics.length; i++) {
      int toAddOrNotToAdd =
          temp.indexWhere((e) => e['clinicName'] == clinics[i].clinicName);
      if (toAddOrNotToAdd == -1) {
        var response = await http.post(
          Uri.parse("${docAPI}/change_clinic_mobile"),
          body: jsonEncode(
              {'clinic_id': clinics[i].clinicID, 'doctor_id': clinics[i].user}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          var result = jsonDecode(response.body.toString());
          ClinicData toAdd =
              ClinicData.fromMap(result["data"]["clinicData"].first);
          UserDatabase().insertClinicData(toAdd);
          UserDatabase().updateClinicID(
              user: clinics[i].user,
              clinicName: clinics[i].clinicName,
              clinicID: clinics[i].clinicID);
          print("added");
        } else {
          print(response.statusCode);
        }
      }
    }
  }
}
