import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:news_list/control/dataBaseHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
            onPressed: () {
              print('hi');
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
