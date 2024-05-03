import 'package:http/http.dart' as http;

/*
      flutter run -d chrome --web-browser-flag "--disable-web-security"
*/

class Site {
  static String domain = "cocohaursignature.com";
  static String imgDomain = "cocohairsignature.com";
}

class Tools {
  static Future<http.Response> httpPost(Map<String, String> dataPost) async {
    var response = await http.post(
        Uri.parse('https://5c34-172-59-112-200.ngrok-free.app/_null.php'),
        headers: {
          //'Content-Type': 'application/json',
        },
        body: dataPost);

    return response;
  }
  //
  //
}
