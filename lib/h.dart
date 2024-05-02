import 'package:http/http.dart' as http;

class Site {
  static String domain = "cocohaursignature.com";
}

class Tools {
  static Future<http.Response> httpPost(Map<String, String> dataPost) async {
    var response = await http.post(Uri.parse('http://dropship.oo/_null.php'),
        headers: {
          //'Content-Type': 'application/json',
        },
        body: dataPost);

    return response;
  }
}
