import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:news_list/control/dataBaseHelper.dart';
import 'localDetailPage.dart';

class LocalData extends StatefulWidget {
  const LocalData({Key? key}) : super(key: key);

  @override
  _LocalDataState createState() => _LocalDataState();
}

class _LocalDataState extends State<LocalData> {
  Future<List> getLocalData() async {
    return await DatabaseHelper.instance.queryAll();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: FutureBuilder(
          future: getLocalData(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                mainAxisSpacing: 5,
                itemCount: (snapshot.data as List).length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(() => ContentPage((snapshot.data as List)[index],
                              (snapshot.data as List)[index]['_id']))!
                          .then((value) {
                        setState(() {});
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2, right: 2),
                      child: Image.network('https://image.tmdb.org/t/p/w185' +
                          (snapshot.data as List)[index]['poster_path']),
                    ),
                  );
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              );
            } else {
              return Container(
                child: Center(
                  child: Text('Loading...'),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
