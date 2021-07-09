import 'package:http/http.dart' as http;
import 'dart:convert';

class Content {
  String endUrl =
      'https://newsapi.org/v2/everything?q=gaming&pagesize=10&language=en&from=2021-07-05&sortBy=popularity&apiKey=5ebb3084c4c54138b9330448480c611a';
  Future<dynamic> getRawData({int pageNum = 1}) async {
    http.Response response =
        await http.get(Uri.parse(endUrl + '&page=$pageNum'));
    if (response.statusCode == 200) {
      var rawData = jsonDecode(response.body);
      return rawData['articles'];
    } else {
      print(response.statusCode);
    }
  }
}
