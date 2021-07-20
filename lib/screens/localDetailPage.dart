import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:news_list/control/dataBaseHelper.dart';
import 'package:news_list/controller/movie_controller.dart';

class ContentPage extends StatelessWidget {
  final int index;
  final Map data;
  final MovieController movieController = Get.find();
  ContentPage(this.data, this.index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['original_title']),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                  'https://image.tmdb.org/t/p/w300' + data['poster_path']),
              SizedBox(
                height: 20.0,
              ),
              Text(
                data['overview'],
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          for (var x in movieController.movieList) {
            if (x.posterPath == data['poster_path']) {
              var newVal = x;
              newVal.fav = !newVal.fav;
              x = newVal;
            }
          }
          DatabaseHelper.instance.delete(index);
          Get.back();
        },
        child: Icon(Icons.favorite, color: Colors.red[400]),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
