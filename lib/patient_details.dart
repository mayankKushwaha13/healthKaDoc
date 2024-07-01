import 'package:flutter/material.dart';

class PatientDetails extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController ageController;
  final TextEditingController phoneController;
  final TextEditingController complaintController;
  final String gender;
  final ValueChanged<String?> onGenderChanged;

  PatientDetails({
    required this.nameController,
    required this.ageController,
    required this.phoneController,
    required this.complaintController,
    required this.gender,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Patient Details:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),

        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: 'Patient Name',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 8),


        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: ageController,
                decoration: InputDecoration(
                  hintText: 'Age',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(width: 8),

            Expanded(

              child: DropdownButtonFormField<String>(
                value: gender,
                items: ['Male', 'Female', 'Other'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: onGenderChanged,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),


        TextFormField(
          controller: phoneController,
          decoration: InputDecoration(
            hintText: 'Phone Number',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 8),

        TextFormField(
          controller: complaintController,
          decoration: InputDecoration(
            hintText: 'Complaint',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}