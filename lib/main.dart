import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_list/controller/movie_controller.dart';
import 'screens/localScreen.dart';
import 'screens/detailPage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

void main() {
  runApp(Moubie());
}

class Moubie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter News App',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MovieController movieController = Get.put(MovieController());
  ScrollController controller = ScrollController();
  int i = 1;

  @override
  void initState() {
    super.initState();
    controller.addListener(listenScrolling);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void listenScrolling() {
    if (controller.position.atEdge) {
      final isTop = controller.position.pixels == 0;
      if (isTop) {
        if (i > 1) {
          i--;
          movieController.fetchMovie(page: i);
        }
      } else {
        setState(() {
          i++;
          movieController.fetchMovie(page: i);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('App'),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.favorite),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Obx(() => StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5,
                  controller: controller,
                  itemCount: movieController.movieList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => ContentPage(index));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: Image.network('https://image.tmdb.org/t/p/w185' +
                            movieController.movieList[index].posterPath),
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                )),
            LocalData(),
          ],
        ),
      ),
    );
  }
}
