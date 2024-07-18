import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prescription/constants/API%20links/doctorAPI.dart';
import 'package:prescription/data/shared_preference.dart';
import 'package:prescription/data/user_database.dart';
import 'package:prescription/model/user.dart';
import 'package:prescription/pages/home_page.dart';
import 'package:prescription/widgets/circular_design.dart';
import 'package:prescription/widgets/textfieldsWidgets/my_textfield.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username = TextEditingController();

  final password = TextEditingController();

  bool isLogging = false;
  bool apiCalled = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo.shade100,
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularDesign(
                radius: 400,
                opacity: 0.3,
                x: -width / 2,
                y: -height / 2,
                color: Colors.red.shade900,
              ),
              CircularDesign(
                radius: 360,
                opacity: 0.3,
                x: width / 2,
                y: height / 2,
                color: Colors.red.shade900,
              ),
              CircularDesign(
                radius: 200,
                opacity: 0.25,
                y: height / 2,
                color: Colors.red.shade900,
              ),
              CircularDesign(
                radius: 200,
                opacity: 0.25,
                y: -height / 2,
                color: Colors.red.shade900,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image(
                        image: AssetImage("lib/assets/nexus_.png"),
                        height: 180,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    controller: username,
                    hint: "Enter Username",
                    bold: true,
                    color: Colors.red.shade900,
                    textColor: Colors.yellow.shade100,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    controller: password,
                    hint: "Enter Password",
                    bold: true,
                    color: Colors.red.shade900,
                    textColor: Colors.yellow.shade100,
                    obscure: true,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Ink(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade900,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: isLogging? (){} : () async {
                          var response = await login(
                              username: username.text, password: password.text);
                          if ((response == "Valid") ||
                              (response != null &&
                                  (response.statusCode.toString()[0] == "2" ||
                                      response.statusCode == 200))) {
                            SP.sp!.setBool(SP.login, true);
                            SP.sp!.setString(SP.user, username.text);
                            SP.sp!.setString(SP.password, password.text);
                            if (apiCalled == true) {
                              final result = jsonDecode(response.body);
                              User doctor = User.fromMap(result);
                              var docList = await UserDatabase().readDocInfo();
                              var userFound = docList.indexWhere((element) =>
                                  element.user == SP.sp!.getString(SP.user));
                              if (userFound == -1) {
                                UserDatabase().insertData(doctor);
                              }
                              SP.sp!.setString(
                                  SP.firstName, doctor.doctorData.firstName);
                              SP.sp!.setString(
                                  SP.secondName, doctor.doctorData.secondName);
                              SP.sp!.setString(SP.currClinic, doctor.clinicNameWithID.first['clinic_id']);
                            }
                            setState(() {
                              isLogging = true;
                            });
                            Future.delayed(const Duration(milliseconds: 1500),
                                () {
                              setState(() {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePage()));
                                isLogging = false;
                              });
                            });
                          } else if (response == 'Invalid') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  "Password is incorrect for the given user ID"),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Invalid credentials : ${response.statusCode}"),
                            ));
                          }
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: isLogging
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    "Login",
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  login({required String username, required String password}) async {
    try {
      // if ((username == SP.sp!.getString(SP.user))&&(password == SP.sp!.getString(SP.password))) {
      //     return "Valid";
      // }
      // else
      {
        apiCalled = true;
        Map<String, dynamic> body = {
          "doctor_id": username,
          "password": password
        };
        String jsonBody = jsonEncode(body);
        var response = await http.post(
          Uri.parse("$docAPI/mobile_login"),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonBody,
        );
        print(response.statusCode);
        return response;
      }
    } catch (e) {
      print(e);
    }
  }
}
