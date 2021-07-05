import 'apiFetch.dart';

class Data {
  late var title, description, imageURL;
  late int len;
  var content;

  Future<List<List>> addToList({int number = 1}) async {
    try {
      content = await Content().getRawData(pageNum: number);
      len = content.length;
    } catch (e) {
      print(e);
    }
    List<List> newsContent = [];
    for (int i = 0; i < len; i++) {
      title = content[i]['title'];
      description = content[i]['description'];
      imageURL = content[i]['urlToImage'];
      newsContent.add([title, description, imageURL]);
    }
    return newsContent;
  }
}
