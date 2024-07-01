
import 'package:flutter/material.dart';
import 'package:prescription/widgets/drawer_widget.dart';
import 'package:prescription/widgets/homePageWidgets/doctor_container.dart';
import 'package:prescription/widgets/header.dart';
import 'package:prescription/widgets/homePageWidgets/my_bar_chart.dart';
import 'package:prescription/widgets/homePageWidgets/my_line_chart.dart';
import 'package:prescription/widgets/homePageWidgets/patientsWidget.dart';
import 'package:prescription/widgets/homePageWidgets/recordsWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        drawer: DrawerWidget(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Header(),
              DoctorContainer(
                doctor: "Dr. Mayank Kushwaha",
              ),
              AppointmentContainer(),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Records(),
                    Patients(),
                  ],
                ),
              ),
              MyLineChart(),
              MyBarChart(),
            ],
          ),
        ),
      ),
    );
  }
}

