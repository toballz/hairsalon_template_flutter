import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:webclient/main.dart';
import 'package:webclient/profileedit.dart';

/*
      flutter run -d chrome --web-browser-flag "--disable-web-security"
*/

class Site {
  //static String domain = "cocohairsignature.com";
  //static String domain = "3b67-172-59-112-200.ngrok-free.app/_null2";
  static String get getCurrentUserDomain {
    String? th = Tools.localstorage.getItem('userDomainId');
    return th ?? "";
  }
}

///bgcolorDark,  tabcolorDark,  textcolorDark
class ColorPallette {
  static Color backgroundColor() {
    return (Tools.themeDark)
        ? (const Color.fromARGB(255, 21, 32, 54))
        : (const Color.fromARGB(255, 255, 255, 255));
  }

  static Color fontColor() {
    return (Tools.themeDark)
        ? (const Color.fromARGB(255, 255, 255, 255))
        : (const Color.fromARGB(255, 4, 0, 0));
  }

  static Color tabColor() {
    return (Tools.themeDark)
        ? (const Color.fromARGB(255, 35, 55, 95))
        : (const Color.fromARGB(255, 35, 55, 95));
  }
}

class Tools {
  static bool themeDark = false;
  static final LocalStorage localstorage = LocalStorage("gjhdafs");

  ///yyyymmdd
  static final todayDate = DateUtils.dateOnly(DateTime.now());

  static getReadyAll() async {
    await Tools.localstorage.ready;
  }

  static Future<http.Response> httpPost(Map<String, String> dataPost) async {
    var response = await http.post(
        Uri.parse('https://${Site.getCurrentUserDomain}/i/api.php'),
        headers: {
          //'Content-Type': 'application/json',
        },
        body: dataPost);

    return response;
  }

  //
  static void scrollToBottom(ScrollController scl) {
    scl.animateTo(
      scl.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
  //

  static String dateIntToDaysMonth(String dateInr) {
    DateTime date = DateTime.parse(
        '${dateInr.substring(0, 4)}-${dateInr.substring(4, 6)}-${dateInr.substring(6, 8)}');
    String formattedDate = DateFormat.yMMMMd('en_US').format(date);
    String dayOfWeek = DateFormat.EEEE('en_US').format(date);
    return '$dayOfWeek $formattedDate';
  }

  static String timeMilitaryToRegular(String timeInr) {
    String time24Hour = timeInr;

    // Parse the time string into a DateTime object
    DateTime time = DateFormat.Hm().parse(time24Hour);

    // Format the DateTime object to 12-hour format with AM/PM
    return DateFormat('hh:mm a').format(time);
  }

  ///domain, password
  static String login(String domain, String password, BuildContext contex) {
    RegExp domainRegex = RegExp(r'^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    //if (domainRegex.hasMatch(domain)) {
    if (domain.length > 5) {
      Tools.localstorage.setItem("userDomainId", domain);
      Navigator.pushReplacement(
          contex, MaterialPageRoute(builder: (context) => const MyHomePage()));

      //httpPost({"v": "1"});
    } else {
      Fluttertoast.showToast(
          msg: "Please enter a valid domain !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black26,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return "";
  }

  static void logout(BuildContext contex) {
    Tools.localstorage.deleteItem("userDomainId");
    Navigator.pushReplacement(
        contex, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  static Future<bool> isLoggedIn() async {
    if (Site.getCurrentUserDomain == "") {
      return false;
    } else if (Site.getCurrentUserDomain.length > 4) {
      return true;
    } else {
      return false;
    }
  }
}
