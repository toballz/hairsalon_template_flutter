import 'dart:convert';

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
  static String getCurrentUserDomain = "cocohairsignature.com";
  static String monthlyStripePayment = (1 == 1)
      ? "https://buy.stripe.com/5kA8xDeI3bYKf7y5kl"
      : "https://buy.stripe.com/test_fZeg2269k56rbN6aEE";
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
  static bool get themeDark {
    String? ii = localStorage.getItem("themeIsDark");
    if (ii != null) {
      return ((ii.toLowerCase() == "true") ? true : false);
    }
    return false;
  }

  ///yyyymmdd
  static final todayDate = DateUtils.dateOnly(DateTime.now());

  static getReadyAll() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initLocalStorage();
  }

  static Future<http.Response> httpPost(Map<String, String> dataPost) async {
    var response = await http.post(
        Uri.parse('https://${Site.getCurrentUserDomain}/i/api.php'),
        headers: {},
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
    // Parse military time
    int militaryHour = int.parse(timeInr.substring(0, 2));
    int militaryMinute = int.parse(timeInr.substring(2, 4));
    // Format regular time
    String period = militaryHour < 12 ? 'AM' : 'PM';
    int regularHour = militaryHour > 12 ? militaryHour - 12 : militaryHour;
    String regularTime =
        '${regularHour.toString().padLeft(2, '0')}:${militaryMinute.toString().padLeft(2, '0')} $period';

    return regularTime;
  }

  ///domain, password
  static void login(String emaili, String password, BuildContext contex) {
    //if (domainRegex.hasMatch(domain)) {
    if (emaili.length > 5) {
      Tools.httpPost({
        "v": "1",
        "logine": "0",
        "password": base64Encode(utf8.encode(password)),
        "email": base64Encode(utf8.encode(emaili.trim()))
      }).then((value) {
        var tt = jsonDecode(value.body);
        if (tt!['code'] == 200) {
          localStorage.setItem("userEmail", emaili);
          Navigator.pushReplacement(contex,
              MaterialPageRoute(builder: (context) => const MyHomePage()));
        } else {
          Fluttertoast.showToast(
              msg: tt!['message'] ?? "Error",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color.fromARGB(66, 74, 54, 54),
              textColor: Colors.white,
              fontSize: 16.0);
        }
      });
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
  }

  static void logout(BuildContext contex) {
    localStorage.removeItem("userEmail");
    Navigator.pushReplacement(
        contex, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  static Future<bool> isLoggedIn() async {
    var taa = localStorage.getItem("userEmail");

    if (taa == null || taa.isEmpty || taa.length < 4) {
      return false;
    } else {
      return true;
    }
  }

//check subscriptions
  static Future<bool> checkHasSubscription() async {
    final response = await httpPost(
        {'v': '1', 'subscribed': '1', 'subscribed1': '2', 'subscribedr': '3'});
    var af = jsonDecode(response.body);
    if (af['code'] == 200) {
      return true;
    } else {
      return false;
    }
  }
}
