import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

/*
      flutter run -d chrome --web-browser-flag "--disable-web-security"
*/

class Site {
  //static String domain = "cocohairsignature.com";
  static String domain = "3b67-172-59-112-200.ngrok-free.app/_null2";
  static String imgDomain = "cocohairsignature.com";
}

class Tools {
  static bool themeDark = false;

  ///yyyymmdd
  static final todayDate = DateUtils.dateOnly(DateTime.now());

  ///bgcolorDark,  tabcolorDark,  textcolorDark
  static Map<String, Color> colorShuttle = {
    "bgcolorDark": const Color.fromARGB(255, 21, 32, 54),
    "bgcolorLight": const Color.fromARGB(255, 255, 255, 255),
    "tabcolorDark": const Color.fromARGB(255, 35, 55, 95),
    "tabcolorLight": const Color.fromARGB(255, 35, 55, 95),
    "textcolorDark": const Color.fromARGB(255, 255, 255, 255),
    "textcolorLight": const Color.fromARGB(255, 4, 0, 0),
  };

  static Future<http.Response> httpPost(Map<String, String> dataPost) async {
    var response =
        await http.post(Uri.parse('https://${Site.domain}/i/api.php'),
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
}
