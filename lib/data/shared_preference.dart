import 'package:shared_preferences/shared_preferences.dart';

class SP {      
  static SharedPreferences? sp;
  static String user = "user";
  static String clinicID = "clinicID";
  static String login = "login";
  static String password = "password";
  static String firstName = "firstName";
  static String secondName = "secondName";
  static String currClinic = "currentClinic";
  static Future init() async {
    sp = await SharedPreferences.getInstance();
  }
}