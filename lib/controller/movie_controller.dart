import 'package:get/state_manager.dart';
import 'package:news_list/models/news_model.dart';
import 'package:news_list/control/apiFetch.dart';
import 'package:news_list/control/dataBaseHelper.dart';

class MovieController extends GetxController {
  var movieList = <Result>[].obs;
  var localList = <Result>[].obs;

  @override
  void onInit() {
    fetchMovie();
    fetchDatabase();
    super.onInit();
  }

  void fetchMovie({int page = 1}) async {
    var movieData = await Content().getRawData(pageNum: page);
    if (movieData != null) {
      for (var map in movieData) {
        movieList.add(Result(
            originalTitle: map['original_title'],
            posterPath: map['poster_path'],
            overview: map['overview']));
      }
    }
  }

  void fetchDatabase() async {
    localList = <Result>[].obs;
    var localData = await DatabaseHelper.instance.queryAll();
    if (localData.isNotEmpty) {
      for (var map in localData) {
        localList.add(Result(
            originalTitle: map['original_title'],
            posterPath: map['poster_path'],
            overview: map['overview'],
            fav: true));
      }
    }
    localList.refresh();
  }
}
