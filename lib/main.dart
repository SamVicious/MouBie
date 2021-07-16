import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_list/controller/movie_controller.dart';
import 'screens/localScreen.dart';
import 'control/apiFetch.dart';
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
  Future addToListFinal() async {
    List<dynamic> newsContent = await Content().getRawData(pageNum: i);
    return newsContent;
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(listenScrolling);
    print(movieController.movieList.length);
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
          addToListFinal().then((value) =>
              controller.jumpTo(controller.position.maxScrollExtent - 0.1));
          setState(() {});
        }
      } else {
        addToListFinal().then((value) => controller.jumpTo(0.1));
        setState(() {
          i++;
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
                        Get.to(ContentPage(index));
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
