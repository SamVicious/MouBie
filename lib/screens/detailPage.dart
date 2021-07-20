import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:news_list/control/dataBaseHelper.dart';
import 'package:news_list/controller/movie_controller.dart';

class ContentPage extends StatelessWidget {
  final int index;
  ContentPage(this.index);
  final MovieController movieController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movieController.movieList[index].originalTitle),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network('https://image.tmdb.org/t/p/w300' +
                  movieController.movieList[index].posterPath),
              SizedBox(
                height: 20.0,
              ),
              Text(
                movieController.movieList[index].overview,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Obx(() => FloatingActionButton(
            onPressed: () async {
              if (movieController.movieList[index].fav) {
                for (var x in await DatabaseHelper.instance.queryAll()) {
                  print(x);
                  print(movieController.movieList[index].posterPath);
                  if (x['poster_path'] ==
                      movieController.movieList[index].posterPath) {
                    await DatabaseHelper.instance
                        .delete(x['_id'])
                        .then((value) => movieController.onInit());
                    Get.snackbar('Success', 'Removed from Favourite');
                  }
                }
              } else {
                Get.snackbar('Success', 'Added to Favourite');
                await DatabaseHelper.instance.insert({
                  'original_title':
                      movieController.movieList[index].originalTitle,
                  'poster_path': movieController.movieList[index].posterPath,
                  'overview': movieController.movieList[index].overview
                }).then((value) => movieController.onInit());
              }
              var newVal = movieController.movieList[index];
              newVal.fav = !newVal.fav;
              movieController.movieList[index] = newVal;
            },
            child: Icon(
              Icons.favorite,
              color: movieController.movieList[index].fav
                  ? Colors.red[400]
                  : Colors.white,
            ),
            backgroundColor: Colors.grey,
          )),
    );
  }
}
