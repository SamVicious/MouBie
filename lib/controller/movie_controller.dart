import 'package:get/state_manager.dart';
import 'package:news_list/models/news_model.dart';
import 'package:news_list/control/apiFetch.dart';

class MovieController extends GetxController {
  var movieList = <Result>[].obs;

  @override
  void onInit() {
    fetchMovie();
    super.onInit();
  }

  void fetchMovie() async {
    var movieData = await Content().getRawData();
    if (movieData != null) {
      for (var map in movieData) {
        movieList.add(Result(
            originalTitle: map['original_title'],
            posterPath: map['poster_path'],
            overview: map['overview']));
      }
    }
  }
}
