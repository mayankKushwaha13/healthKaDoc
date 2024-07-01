import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prescription/widgets/drawer_widget.dart';
import 'package:prescription/widgets/header.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        body: SingleChildScrollView(
                child: Column(
        children: [
        const Header(),
        Container(
          alignment: Alignment.topCenter,
          height: 60,
          decoration: BoxDecoration(
              color: Colors.pink.shade400,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100))),
          child: Text(
            "Records",
            style: GoogleFonts.openSans(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Name${index + 1}"),
                  subtitle: const Text("Number"),
                  trailing: const Icon(Icons.add),
                );
              }),
        )
                ]),
              ),
      ),
    );
  }
}
