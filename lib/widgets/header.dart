import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prescription/constants/colors.dart';
import 'package:prescription/pages/docProfilePages/doc_profile.dart';

class Header extends StatefulWidget {
  const Header({super.key, this.onChanged});
  final void Function(String)? onChanged;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: MyColor.pink),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white),
                  child: const Icon(
                    Icons.menu,
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: TextField(
                  onChanged: widget.onChanged,
              decoration: InputDecoration(
                  hintText: "Search...",
                  suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          FocusScope.of(context).unfocus();
                        });
                      },
                      child: const Icon(
                        Icons.search,
                        size: 28,
                      )),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ))),
              style: GoogleFonts.aBeeZee(
                fontSize: 16,
              ),
            )),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const DocProfilePage()));
              },
              child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white),
                  child: const Icon(
                    Icons.person,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
