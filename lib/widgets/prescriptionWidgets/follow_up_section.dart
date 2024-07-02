import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowUpSection extends StatefulWidget {
  final TextEditingController dateController;
  final TextEditingController timeController;
  const FollowUpSection({super.key, required this.dateController, required this.timeController});

  @override
  State<FollowUpSection> createState() => _FollowUpSectionState();
}

class _FollowUpSectionState extends State<FollowUpSection> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.indigo[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
                color: Colors.pink.shade900
              ),
              child: TextFormField(
                style: GoogleFonts.aBeeZee(color: Colors.white),
                textAlignVertical: TextAlignVertical.center,
                controller: widget.dateController,
                decoration: InputDecoration(
                  hintText: 'Follow Up Date',
                  hintStyle: GoogleFonts.aBeeZee(color: Colors.white70),
                  suffixIcon: Icon(
                    Icons.calendar_today,
                    color: Colors.pink.shade100,
                  ),
                  border: InputBorder.none,
                ),
                readOnly: true,
                onTap: () {
                  selectDate();
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
                color: Colors.pink.shade900
              ),
              child: TextFormField(
                style: GoogleFonts.aBeeZee(color: Colors.white),
                textAlignVertical: TextAlignVertical.center,
                controller: widget.timeController,
                decoration: InputDecoration(
                  hintText: 'Follow Up Time',
                  hintStyle: GoogleFonts.aBeeZee(color: Colors.white70),
                  suffixIcon: Icon(
                    CupertinoIcons.clock,
                    color: Colors.pink.shade100,
                  ),
                  border: InputBorder.none,
                ),
                readOnly: true,
                onTap: () {
                  selectTime();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime(2100));

    if (picked != null) {
      setState(() {
        widget.dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> selectTime() async {
    TimeOfDay? picked =
        await showTimePicker(
          context: context, 
          initialTime: TimeOfDay.now()
        );

    if(picked != null){
      setState(() {
        widget.timeController.text = "${picked.hour} : ${picked.minute}";
      });
    }
  }
}
