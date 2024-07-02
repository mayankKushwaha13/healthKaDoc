import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

String api3 =
    "https://clinicaltables.nlm.nih.gov/api/icd10cm/v3/search?sf=name&terms=";
List<dynamic> diagnosis = [];

List<String> diagnosisList = [];

class DiagnosisSection extends StatefulWidget {
  final TextEditingController diagnosisController;

  const DiagnosisSection({super.key, required this.diagnosisController});

  @override
  State<DiagnosisSection> createState() => _DiagnosisSectionState();
}

class _DiagnosisSectionState extends State<DiagnosisSection> {
  final ScrollController scrollController =
      ScrollController(initialScrollOffset: 50.0);

  autoCompleteSearch(String value) async {
    diagnosis.clear();
    api3 =
        "https://clinicaltables.nlm.nih.gov/api/icd10cm/v3/search?sf=name&terms=$value";
    var result = await http.get(Uri.parse(api3));
    var data1 = jsonDecode(result.body.toString());
    if (result.statusCode == 200 && mounted) {
      setState(() {
        diagnosis.clear();
        diagnosis = data1[3];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.indigo.shade50,
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Diagnosis:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700),
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
                        onPressed: (){
                          setState(() {
                            widget.diagnosisController.clear();
                          });
                        }
                      , icon: Icon(CupertinoIcons.multiply, color: Colors.red.shade900,)),
                        hintText: 'Diagnosis',
                        hintStyle: GoogleFonts.lato(color: Colors.black54)),
                    controller: widget.diagnosisController,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          autoCompleteSearch(value);
                        });
                      }
                      if (value.isEmpty || value == "") {
                        diagnosis.clear();
                      }
                    },
                    onSubmitted: (value) {
                      setState(() {
                        diagnosisList.add(value);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: diagnosis.isEmpty ? 1 : diagnosis.length < 3 ? diagnosis.length : 3,
                      itemBuilder: (context, index) {
                        return diagnosis.isEmpty
                            ? widget.diagnosisController.text == ""? Container() :
                            Card(
                                  color: Colors.indigo.shade500,
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        diagnosisList.add(widget.diagnosisController.text);
                                      });
                                    },
                                    title: Text(
                                      widget.diagnosisController.text,
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
                                      diagnosisList.add(diagnosis[index][1]);
                                    });
                                  },
                                  title: Text(
                                    diagnosis[index][1],
                                    style: GoogleFonts.aBeeZee(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              );
                      }),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Iterable<Widget> get symptoms {
    return diagnosisList.map((e) {
      int index = diagnosisList.lastIndexOf(e);
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
              diagnosisList.removeAt(index);
            });
          },
        ),
      );
    });
  }
}
