
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prescription/constants/colors.dart';
import 'package:prescription/data/appointments_database.dart';
import 'package:prescription/pages/clinic_notes_page.dart';
import 'package:prescription/widgets/circular_design.dart';

import '../../model/appointment.dart';

class DoctorContainer extends StatefulWidget {
  const DoctorContainer({super.key, required this.doctor});
  
  final doctor;

  @override
  State<DoctorContainer> createState() => _DoctorContainerState();
}

class _DoctorContainerState extends State<DoctorContainer> {
  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColor.pink,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularDesign(
            radius: 350,
            x: -width / 2,
          ),
          const CircularDesign(
            radius: 500,
            y: 200,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              "lib/assets/doc.png",
              width: 300,
            ),
          ),
          CircularDesign(
            radius: 50,
            x: width / 2 - 50,
            y: -100,
          ),
          CircularDesign(
            radius: 35,
            x: width / 2 - 50,
            y: -100,
            color: MyColor.pink,
            opacity: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              transform: Matrix4.translationValues(0, 98, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome,",
                        style: GoogleFonts.slabo13px(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        "${widget.doctor}",
                        style: GoogleFonts.aBeeZee(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 2,
                    indent: 300,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AppointmentContainer extends StatelessWidget {
  const AppointmentContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // weekday(value) {
    //   return value == 1
    //       ? "Monday"
    //       : value == 2
    //           ? "Tuesday"
    //           : value == 3
    //               ? "Wednesday"
    //               : value == 4
    //                   ? "Thursday"
    //                   : value == 5
    //                       ? "Friday"
    //                       : value == 6
    //                           ? "Saturday"
    //                           : "Sunday";
    // }

    return FutureBuilder(
        future: AppointmentsDB().readAppointments(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Appointment> appointments = snapshot.data!;
            Appointment apt = appointments[0];
            for (int i = 0; i < appointments.length; i++){
              var appointment = appointments[i];
              DateTime aptDate = DateTime.parse(apt.appointmentDate.split("/").reversed.join("-"));
              // var aptTemp = appointment.appointmentTime.split(":");
              // TimeOfDay aptTime = TimeOfDay(hour: int.parse(aptTemp[0]), minute: int.parse(aptTemp[1]));
              DateTime date = DateTime.parse(appointment.appointmentDate.split("/").reversed.join("-"));
              // var temp = appointment.appointmentTime.split(":");
              // TimeOfDay time = TimeOfDay(hour: int.parse(temp[0]), minute: int.parse(temp[1]));
              DateTime today = DateTime.now();
              if(aptDate.difference(today).inSeconds.isNegative){
                apt = appointment;
              }
              if((date.difference(today).inSeconds)<= (aptDate.difference(today).inSeconds)
              && date.year >= today.year && date.month >= today.month && date.day >= today.day
              && aptDate.year <= today.year && aptDate.month <= today.month && aptDate.day <=today.day
              ){
                apt = appointment;
              }
            }
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                ClinicNotesPage(
                  name: apt.patientName,
                  age: apt.age,
                  gender: apt.gender,
                )));
              },
              child: Container(
                transform: Matrix4.translationValues(0, -100, 0),
                child: Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Next Appointment",
                              style: GoogleFonts.lato(
                                fontSize: 19,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Text(
                              apt.appointmentTime,
                              style: GoogleFonts.abel(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: MyColor.pink,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  // "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                  apt.appointmentDate,
                                  style: GoogleFonts.aBeeZee(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                // Text(
                                //   weekday(DateTime.now().weekday),
                                //   style: GoogleFonts.aBeeZee(
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // )
                              ],
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //     top: 30,
                            //   ),
                            //   child: Container(
                            //     padding: const EdgeInsets.all(10),
                            //     decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(10),
                            //         color: Colors.blue.shade100),
                            //     child: Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Icon(
                            //           Icons.location_on,
                            //           color: MyColor.pink,
                            //         ),
                            //         const SizedBox(
                            //           width: 5,
                            //         ),
                            //         const Text(
                            //           "Address adress adress",
                            //           style: TextStyle(
                            //             fontWeight: FontWeight.bold,
                            //             fontSize: 12,
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 10, right: 15, left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.blue.shade100,
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: MyColor.blue,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                apt.patientName,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.aBeeZee(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Constant headache, Mild fever",
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue.shade100),
                                  child: Text(
                                    apt.appointmentType == "0" ? "Check Up" : "Follow Up",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
