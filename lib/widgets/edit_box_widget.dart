import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prescription/widgets/textfieldsWidgets/edit_textfield_widget.dart';

class EditBoxDoctorWidget extends StatefulWidget {
  const EditBoxDoctorWidget({
    super.key,
    required this.visibility,
    required this.emailController,
    required this.phoneController,
    this.onTap,
    this.onBack,
    this.days,
  });
  final bool visibility;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final void Function()? onTap;
  final void Function()? onBack;
  final List<String>? days;

  @override
  State<EditBoxDoctorWidget> createState() => _EditBoxDoctorWidgetState();
}

class _EditBoxDoctorWidgetState extends State<EditBoxDoctorWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Visibility(
        visible: widget.visibility,
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.indigo.shade900,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Text(
                      "Edit Doctor Data",
                      style: GoogleFonts.josefinSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                const SizedBox(
                  height: 10,
                ),
                EditTextField(
                    controller: widget.emailController, title: "Enter Email : ",),
                const SizedBox(
                  height: 10,
                ),
                EditTextField(
                    controller: widget.phoneController,
                    title: "Enter Phone : "),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: widget.onBack,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.pink.shade900,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Close (Without Saving)",
                            style: GoogleFonts.aBeeZee(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )),
                    TextButton(
                        onPressed: widget.onTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade900,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Save",
                            style: GoogleFonts.aBeeZee(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}