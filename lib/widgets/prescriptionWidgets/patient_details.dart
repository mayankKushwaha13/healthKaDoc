import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

String api =
    "https://clinicaltables.nlm.nih.gov/api/conditions/v3/search?terms=&sf=consumer_name";
String api2 =
    "https://clinicaltables.nlm.nih.gov/api/conditions/v3/search?terms=&df=synonyms";

List<String> complaintsList = [];
List<dynamic> predictions = [];
List<dynamic> rawList = [];
List<dynamic> predictions2 = [];

class PatientDetails extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController ageController;
  final TextEditingController phoneController;
  final TextEditingController complaintController;
  final String gender;
  final ValueChanged<String?> onGenderChanged;

  const PatientDetails({
    super.key,
    required this.nameController,
    required this.ageController,
    required this.phoneController,
    required this.complaintController,
    required this.gender,
    required this.onGenderChanged,
  });

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  final ScrollController scrollController =
      ScrollController(initialScrollOffset: 50.0);
  String query = "";
  autoCompleteSearch(String value) async {
    predictions.clear();
    api =
        "https://clinicaltables.nlm.nih.gov/api/conditions/v3/search?terms=$value&sf=consumer_name";
    api2 =
        "https://clinicaltables.nlm.nih.gov/api/conditions/v3/search?terms=$value&df=synonyms";
    var result = await http.get(Uri.parse(api));
    var data1 = jsonDecode(result.body.toString());
    if (result.statusCode == 200 && mounted) {
      setState(() {
        predictions.clear();
        rawList.clear();
        rawList = data1[3];
        for (int i = 0; i < rawList.length; i++) {
          predictions.add(rawList[i][0].toString());
        }
      });
    }
    var result2 = await http.get(Uri.parse(api2));
    var data2 = jsonDecode(result2.body.toString());
    if (result2.statusCode == 200 && mounted) {
      setState(() {
        predictions2.clear();
        rawList.clear();
        rawList = data2[3];
        for (int i = 0; i < rawList.length; i++) {
          for (int j = 0; j < rawList[i].length; j++) {
            List<String> miniList =
                rawList[i][j].toString().split(",").toList();
            for (int k = 0; k < miniList.length; k++) {
              miniList[k].isEmpty || miniList[k] == ""
                  ? null
                  : predictions2.add(miniList[k]);
            }
          }
        }
        debugPrint(predictions2[0].toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Patient Details:',
          style: GoogleFonts.lato(
              color: Colors.red.shade700,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Necessary Field';
            }
            return null;
          },
          controller: widget.nameController,
          style: GoogleFonts.lato(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Patient Name',
            hintStyle: GoogleFonts.lato(color: Colors.white70),
            fillColor: Colors.pink.shade900,
            filled: true,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Necessary Field';
                  }
                  return null;
                },
                controller: widget.ageController,
                style: GoogleFonts.lato(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Age',
                  hintStyle: GoogleFonts.lato(color: Colors.white70),
                  fillColor: Colors.pink.shade900,
                  filled: true,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: widget.gender,
                items: ['Male', 'Female', 'Other'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.lato(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: widget.onGenderChanged,
                dropdownColor: Colors.pink.shade900,
                iconEnabledColor: Colors.white,
                decoration: InputDecoration(
                  fillColor: Colors.pink.shade900,
                  filled: true,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Necessary Field';
            }
            return null;
          },
          controller: widget.phoneController,
          style: GoogleFonts.lato(color: Colors.white),
          decoration: InputDecoration(
              hintText: 'Phone Number',
              hintStyle: GoogleFonts.lato(color: Colors.white70),
              border: const OutlineInputBorder(),
              fillColor: Colors.pink.shade900,
              filled: true),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.pink.shade900,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.pink.shade900)),
                child: RawScrollbar(
                  controller: scrollController,
                  thumbColor: Colors.pink.shade400,
                  radius: const Radius.circular(1000),
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        Wrap(
                          children: symptoms.toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            widget.complaintController.clear();
                          });
                        },
                        icon: Icon(
                          CupertinoIcons.multiply,
                          color: Colors.red.shade900,
                        )),
                    hintText: 'Complaints',
                    hintStyle: GoogleFonts.lato(color: Colors.black54)),
                controller: widget.complaintController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      autoCompleteSearch(value);
                    });
                  }
                  if (value.isEmpty || value == "") {
                    predictions.clear();
                    predictions2.clear();
                  }
                },
                onSubmitted: (value) {
                  setState(() {
                    complaintsList.add(value);
                  });
                },
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: predictions2.isEmpty
                            ? 1
                            : predictions2.length < 3
                                ? predictions2.length
                                : 3,
                        itemBuilder: (context, index) {
                          return predictions2.isEmpty
                              ? widget.complaintController.text == ""
                                  ? Container()
                                  : Card(
                                      color: Colors.indigo.shade500,
                                      child: ListTile(
                                        onTap: () {
                                          setState(() {
                                            complaintsList.add(widget
                                                .complaintController.text);
                                          });
                                        },
                                        title: Text(
                                          widget.complaintController.text,
                                          style: GoogleFonts.aBeeZee(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                              : Card(
                                  color: Colors.indigo.shade500,
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        complaintsList.add(predictions2[index]);
                                      });
                                    },
                                    title: Text(
                                      predictions2[index],
                                      style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                );
                        }),
                  ),
                  Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            predictions.length < 3 ? predictions.length : 3,
                        itemBuilder: (context, index) {
                          return predictions.isEmpty
                              ? Container()
                              : Card(
                                  color: Colors.indigo.shade500,
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        complaintsList.add(predictions[index]);
                                      });
                                    },
                                    title: Text(
                                      predictions[index],
                                      style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                );
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Iterable<Widget> get symptoms {
    return complaintsList.map((e) {
      int index = complaintsList.lastIndexOf(e);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Chip(
          color: WidgetStatePropertyAll(Colors.indigo.shade400),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10000),
              side: BorderSide(color: Colors.indigo.shade400)),
          deleteIconColor: Colors.white,
          label: Text(
            e,
            style: GoogleFonts.aBeeZee(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onDeleted: () {
            setState(() {
              complaintsList.removeAt(index);
            });
          },
        ),
      );
    });
  }
}
