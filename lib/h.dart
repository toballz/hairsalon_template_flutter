import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/*
      flutter run -d chrome --web-browser-flag "--disable-web-security"
*/

class Site {
  static String domain = "cocohaursignature.com";
  static String imgDomain = "cocohairsignature.com";
}

class Tools {
  static bool themeDark = false;

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
    var response = await http.post(
        Uri.parse('https://f84c-172-59-112-200.ngrok-free.app/_null.php'),
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
}
