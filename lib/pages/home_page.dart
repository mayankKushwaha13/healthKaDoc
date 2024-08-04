import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prescription/constants/API%20links/appointmentsAPI.dart';
import 'package:prescription/data/appointments_database.dart';
import 'package:prescription/data/shared_preference.dart';
import 'package:prescription/functions/getPrescription.dart';
import 'package:prescription/model/appointment.dart';
import 'package:prescription/widgets/drawer_widget.dart';
import 'package:prescription/widgets/homePageWidgets/doctor_container.dart';
import 'package:prescription/widgets/header.dart';
import 'package:prescription/widgets/homePageWidgets/header_home.dart';
import 'package:prescription/widgets/homePageWidgets/my_line_chart.dart';
import 'package:prescription/widgets/homePageWidgets/patientsWidget.dart';
import 'package:prescription/widgets/homePageWidgets/recordsWidget.dart';
import 'package:http/http.dart' as http;

import '../functions/getAppointments.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getAppointments();
    getPrescription();
    String name =
        "${SP.sp!.getString(SP.firstName)!} ${SP.sp!.getString(SP.secondName)!}";
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const HeaderHome(),
              DoctorContainer(
                doctor: "Dr. $name",
              ),
              const AppointmentContainer(),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Records(),
                    Patients(),
                  ],
                ),
              ),
              // Not needed now
              // const MyLineChart(),
              // Not needed now
              // MyBarChart(),
            ],
          ),
        ),
      ),
    );
  }

  
}
