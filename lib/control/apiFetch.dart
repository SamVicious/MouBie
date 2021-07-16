import 'dart:convert';

import 'package:http/http.dart' as http;

class Content {
  String endUrl =
      'https://api.themoviedb.org/3/movie/popular?api_key=68d1bdeed3c4339850eeeb515e73f059&language=en-US';
  static var client = http.Client();
  Future<dynamic> getRawData({int pageNum = 1}) async {
    http.Response response =
        await client.get(Uri.parse(endUrl + '&page=$pageNum'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['results'];
    } else {
      print(response.statusCode);
    }
  }
}
