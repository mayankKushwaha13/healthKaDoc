import 'package:flutter/material.dart';

class AdviceSection extends StatelessWidget {
  final TextEditingController generalAdviceController;
  final TextEditingController referralController;
  final TextEditingController surgeryAdviceController;

  AdviceSection({
    required this.generalAdviceController,
    required this.referralController,
    required this.surgeryAdviceController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        color: Colors.lightBlue[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Additional Advice:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: generalAdviceController,
                  decoration: InputDecoration(
                    hintText: 'General Advice',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: referralController,
                  decoration: InputDecoration(
                    hintText: 'Referral',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: surgeryAdviceController,
                  decoration: InputDecoration(
                    hintText: 'Surgery Advice',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 16),
              ],
            )
        )
    );
  }
}