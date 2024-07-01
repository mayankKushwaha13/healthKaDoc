import 'package:flutter/material.dart';
import 'package:prescription/widgets/docProfilePageWidgets/appointments_container.dart';
import 'package:prescription/widgets/docProfilePageWidgets/doc_profile_header.dart';
import 'package:prescription/widgets/docProfilePageWidgets/personal_container.dart';

class DocProfilePage extends StatelessWidget {
  const DocProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: const SafeArea(
        child: Column(
          children: [

            DocProfileHeader(),

            AppointmentsContainerDocProfile(),

            PersonalContainerDocProfile()

          ],
        ),
      ),
    );
  }
}