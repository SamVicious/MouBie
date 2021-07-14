import 'package:http/http.dart' as http;
import 'dart:convert';

class Content {
  String endUrl =
      'https://api.themoviedb.org/3/movie/popular?api_key=68d1bdeed3c4339850eeeb515e73f059&language=en-US&page=1';
  Future<dynamic> getRawData({int pageNum = 1}) async {
    http.Response response =
        await http.get(Uri.parse(endUrl)); //'&page=$pageNum'
    if (response.statusCode == 200) {
      var rawData = jsonDecode(response.body);
      return rawData['results'];
    } else {
      print(response.statusCode);
    }
  }
}
