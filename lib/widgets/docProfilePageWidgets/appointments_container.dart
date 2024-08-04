import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prescription/data/appointments_database.dart';
import 'package:prescription/model/appointment.dart';

class AppointmentsContainerDocProfile extends StatelessWidget {
  const AppointmentsContainerDocProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
        ),
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: FutureBuilder(
                future: AppointmentsDB().readAppointments(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Appointment> appointments = snapshot.data!;
                    int appointmentsToday = appointments.where((e) {
                      List<String> dateList = e.appointmentDate.split("/");
                      DateTime today = DateTime.now();
                      return today.day == int.parse(dateList[0]) &&
                          today.month == int.parse(dateList[1]) &&
                          today.year == int.parse(dateList[2]);
                    }).length;
                    int remainingAppointments = appointments.where((e) {
                      List<String> dateList = e.appointmentDate.split("/");
                      List<String> timeList = e.appointmentTime.split(":");
                      DateTime today = DateTime.now();
                      return today.day <= int.parse(dateList[0]) &&
                          today.month <= int.parse(dateList[1]) &&
                          today.year <= int.parse(dateList[2]) &&
                          (today.hour < int.parse(timeList[0]) ||
                              (today.hour == int.parse(timeList[0]) &&
                                  today.minute < int.parse(timeList[1])));
                    }).length;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Text(
                                appointmentsToday.toString(),
                                style: GoogleFonts.acme(
                                  fontSize: 50,
                                  color: Colors.blue.shade300,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                "Appointments Today",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: VerticalDivider(
                            color: Colors.blue.shade300,
                            thickness: 1,
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              child: Text(
                                remainingAppointments.toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.acme(
                                  fontSize: 50,
                                  color: Colors.blue.shade300,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                "Remaining Appointments",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: VerticalDivider(
                            color: Colors.blue.shade300,
                            thickness: 1,
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              child: Text(
                                appointments.length.toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.acme(
                                  fontSize: 50,
                                  color: Colors.blue.shade300,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                "Appointments Total",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue.shade300,
                      ),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}
