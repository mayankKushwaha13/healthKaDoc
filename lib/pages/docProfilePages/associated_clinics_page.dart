import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prescription/constants/colors.dart';
import 'package:prescription/data/shared_preference.dart';
import 'package:prescription/data/user_database.dart';
import 'package:prescription/model/user.dart';
import 'package:prescription/widgets/my_appbar_widget.dart';

class AssociatedClinicsPage extends StatefulWidget {
  const AssociatedClinicsPage({super.key});

  @override
  State<AssociatedClinicsPage> createState() => _AssociatedClinicsPageState();
}

class _AssociatedClinicsPageState extends State<AssociatedClinicsPage> {
  List clinics = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClinicData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: UserDatabase().readClinicNameWithID(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ClinicNameWithID> clinicID = snapshot.data!
                    .where((e) => e.user == SP.sp!.getString(SP.user))
                    .toList();
                clinics = clinics
                    .where((e) => e['user'] == SP.sp!.getString(SP.user))
                    .toList();
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const MyAppBar(title: "Associated Clinics"),
                      const SizedBox(
                        height: 30,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: clinics.length,
                          itemBuilder: (context, index) {
                            var clinic = clinics[index];
                            String thisClinicID = clinicID[clinicID.indexWhere(
                                    (e) =>
                                        e.clinicName == clinic['clinicName'])]
                                .clinicID;
                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.all(13),
                              color: Colors.indigo.shade50,
                              child: Padding(
                                padding: const EdgeInsets.all(13),
                                child: ListTile(
                                  titleAlignment: ListTileTitleAlignment.center,
                                  leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(1000),
                                      child: Image.network(clinic['imageURL'])),
                                  title: Text(
                                    clinic['clinicName'],
                                    style: GoogleFonts.josefinSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  subtitle: Wrap(
                                    children: [
                                      Text(
                                        "Clinic ID : ",
                                        style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        thisClinicID,
                                        style: GoogleFonts.lato(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: MyColor.blue,
                  ),
                );
              }
            }),
      ),
    );
  }

  void getClinicData() async {
    clinics = await UserDatabase().readClinicDataMap();
  }
}
