import 'package:flutter/material.dart';
import 'package:prescription/widgets/patientProfileWidgets/patient_profile_header.dart';
import 'package:prescription/widgets/patientProfileWidgets/recent_visits.dart';
import 'package:prescription/widgets/patientProfileWidgets/vitals_container.dart';

class PatientProfilePage extends StatelessWidget {
  const PatientProfilePage({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          child: Column(
            children: [
              PatientProfileHeader(
                name: name,
              ),
              const VitalsContainer(),
              Padding(
                padding: const EdgeInsets.only(left: 13.0,right: 13,bottom: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Personal Information",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      )
                    ],
                  ),
                ),
              ),
              const RecentVisits(),
            ],
          ),
        ),
      ),
    );
  }
}
