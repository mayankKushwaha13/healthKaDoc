import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalInformationDocWidget extends StatelessWidget {
  const PersonalInformationDocWidget({
    super.key,
    required this.subtitle,
    required this.title,
    required this.icon
  });

  final String subtitle;
  final String title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: ListTile(
      title: Text(title,
      style: GoogleFonts.josefinSans(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle,
            style: GoogleFonts.lato(
              fontSize: 16
            ),
          ),
          const Divider(thickness: 2,)
        ],
      ),
      leading: icon,

    ));
  }
}
