import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prescription/data/shared_preference.dart';
import 'package:prescription/pages/home_page.dart';
import 'package:prescription/pages/login_page.dart';
import 'package:prescription/widgets/circular_design.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo.shade100,
        body: Stack(
          alignment: Alignment.center,
          children: [
            CircularDesign(radius: 400, opacity: 0.3, x: -width/2, y: -height/2, color: Colors.red.shade900,),
                CircularDesign(radius: 360, opacity: 0.3, x: width/2, y: height/2, color: Colors.red.shade900,),
                CircularDesign(radius: 200, opacity: 0.25, y: height/2,color: Colors.red.shade900,),
                CircularDesign(radius: 200, opacity: 0.25, y: -height/2, color: Colors.red.shade900,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset('lib/assets/nexus_.png',height: 150,),
                  ],
                ),
                Image.asset('lib/assets/loading.gif', height: 60,),
              ],
            ),
          ],
        ),
      ),
    );
  }
   void checkLogin()async{
    bool? isLoggedIn = SP.sp!.getBool(SP.login);

    Timer(const Duration(milliseconds: 3550), () {
      if(isLoggedIn != null){
        if(isLoggedIn){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomePage()));
        }
        else{
          Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginPage()));
        }
      }
      else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginPage()));
      }
    });
  }
}