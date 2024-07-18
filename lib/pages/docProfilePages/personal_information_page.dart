import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prescription/constants/API%20links/doctorAPI.dart';
import 'package:prescription/data/doctor_database.dart';
import 'package:prescription/data/shared_preference.dart';
import 'package:prescription/data/user_database.dart';
import 'package:prescription/model/doctor.dart';
import 'package:prescription/model/user.dart';
import 'package:prescription/widgets/drawer_widget.dart';
import 'package:prescription/widgets/edit_box_widget.dart';
import 'package:prescription/widgets/my_appbar_widget.dart';

import 'package:http/http.dart' as http;

import '../../widgets/docProfilePageWidgets/personal_info_doc_widget.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  bool isVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDoctorData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: DrawerWidget(),
        body: FutureBuilder(
          future: DoctorDatabase().readAllData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Doctor> doctorList = snapshot.data![0];
              Doctor doctor = doctorList[doctorList.indexWhere((e)=>e.doctorID == SP.sp!.getString(SP.user))];
              List<Clinic> clinicList = snapshot.data![1];
              Clinic clinic = clinicList[clinicList.indexWhere((e)=>e.doctorID == SP.sp!.getString(SP.user))];
              List<Address> addressList = snapshot.data![2];
              Address address = addressList[addressList.indexWhere((e)=>e.doctorID == SP.sp!.getString(SP.user))];
              List addr = [address.landmark, address.lane, address.addressOne, address.city, address.state, address.country];
              return SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        MyAppBar(title: "Doctor Information"),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.asset(
                                  "lib/assets/doctor.png",
                                  width: 120,
                                )),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              doctor.firstName + "\n" + doctor.secondName,
                              style: GoogleFonts.josefinSans(
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            PersonalInformationDocWidget(
                              title: "DOB", 
                              subtitle: doctor.dob,
                              icon: Icon(CupertinoIcons.calendar, color: Colors.indigo.shade700,),
                            ),
                            PersonalInformationDocWidget(
                              title: "Degree", 
                              subtitle: doctor.qualification,
                              icon: Icon(Icons.school, color: Colors.indigo.shade700,),
                            )
                          ],
                        ),Row(
                          children: [
                            PersonalInformationDocWidget(
                              title: "Gender", 
                              subtitle: doctor.gender.substring(0,1).toUpperCase(),
                              icon: Icon(CupertinoIcons.calendar, color: Colors.indigo.shade700,),
                            ),
                            PersonalInformationDocWidget(
                              title: "Specialization", 
                              subtitle: doctor.specialization,
                              icon: Icon(Icons.school, color: Colors.indigo.shade700,),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            PersonalInformationDocWidget(
                              title: "Phone No.", 
                              subtitle: doctor.phoneNumber,
                              icon: Icon(CupertinoIcons.calendar, color: Colors.indigo.shade700,),
                            ),
                            PersonalInformationDocWidget(
                              title: "Experience", 
                              subtitle: doctor.experience,
                              icon: Icon(Icons.school, color: Colors.indigo.shade700,),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            PersonalInformationDocWidget(
                              title: "Email", 
                              subtitle: doctor.email,
                              icon: Icon(CupertinoIcons.calendar, color: Colors.indigo.shade700,),
                            ),
                            
                          ],
                        ),
                        Row(
                          children: [
                            PersonalInformationDocWidget(
                                  title: "Address", 
                                  subtitle: addr.join(", "),
                                  icon: Icon(Icons.school, color: Colors.indigo.shade700,),
                                ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Ink(
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                setState(() {
                                  isVisible = true;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width / 2 -
                                            30,
                                    vertical: 10),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ],
                    ),
                    EditBoxDoctorWidget(
                      visibility: isVisible,
                      emailController: emailController,
                      phoneController: phoneController,
                      onBack: () {
                        setState(() {
                          isVisible = false;
                        });
                      },
                      onTap: () async {
                        if (emailController.text.isNotEmpty) {
                          var body = {
                            "doctor_id": SP.sp!.getString(SP.user),
                            "email": emailController.text.toString(),
                          };
                          var response = await http.post(
                            Uri.parse("${docAPI}/update_doctor_profile_mobile"),
                            headers: {
                              'Content-type': 'application/json',
                              'Accept': 'application/json',
                            },
                            body: jsonEncode(body),
                          );
                          if (response.statusCode == 200) {
                            print("Updated");
                            UserDatabase().updateData(
                                whereArgs: SP.sp!.getString(SP.user)!,
                                table: "doctorInfo",
                                data: {"email": emailController.text});
                          }
                        }
                        if (phoneController.text.isNotEmpty) {
                          var body = {
                            "doctor_id": SP.sp!.getString(SP.user),
                            "phone_number": phoneController.text.toString(),
                          };
                          var response = await http.post(
                            Uri.parse("${docAPI}/update_doctor_profile_mobile"),
                            headers: {
                              'Content-type': 'application/json',
                              'Accept': 'application/json',
                            },
                            body: jsonEncode(body),
                          );
                          print(response.statusCode);
                          if (response.statusCode == 200) {
                            print("Updated");
                            UserDatabase().updateData(
                                whereArgs: SP.sp!.getString(SP.user)!,
                                table: "doctorInfo",
                                data: {"phoneNumber": phoneController.text});
                          }
                        }
                        emailController.clear();
                        phoneController.clear();
                        setState(() {
                          isVisible = false;
                        });
                      },
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  void getDoctorData() async {
    List<Doctor> doctorList = await DoctorDatabase().readDoctorData();
    List<Address> addressList = await DoctorDatabase().readAddress();
    List<Clinic> clinicList = await DoctorDatabase().readClinic();

    int docFound =
        doctorList.indexWhere((e) => e.doctorID == SP.sp!.getString(SP.user));
    int addFound =
        addressList.indexWhere((e) => e.doctorID == SP.sp!.getString(SP.user));
    int clinFound =
        clinicList.indexWhere((e) => e.doctorID == SP.sp!.getString(SP.user));
    if (docFound == -1 || addFound == -1 || clinFound == -1) {
      var response = await http.post(
          Uri.parse("${docAPI}/get_clinic_doctors_mobile"),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({'doctor_id': SP.sp!.getString(SP.user)}));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        Map<String, dynamic> toAddDoc = result['doctorData'].first;
        Map<String, dynamic> toAddClin = result['clinicData'].first;
        Map<String, dynamic> toAddAddress = result['address'].first;

        if (docFound == -1) {
          DoctorDatabase().insertDocData(Doctor.fromMap(toAddDoc));
          DoctorDatabase().updateDoctor(
              doctorID: SP.sp!.getString(SP.user)!,
              data: {'imageURL': result['imageUrl']});
        }
        if (addFound == -1) {
          DoctorDatabase().insertAddressData(Address.fromMap(toAddAddress));
        }
        if (clinFound == -1) {
          DoctorDatabase().insertClinicData(Clinic.fromMap(toAddClin));
        }
      } else {
        print(response.statusCode);
      }
    }
  }
}

