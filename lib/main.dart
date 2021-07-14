import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/localScreen.dart';
import 'control/apiFetch.dart';
import 'screens/detailPage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News App',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            Container(
              child: Card(
                child: FutureBuilder(
                  future: addToListFinal(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return StaggeredGridView.countBuilder(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        controller: controller,
                        itemCount: (snapshot.data! as List).length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContentPage(
                                          (snapshot.data! as List)[index])));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.network(
                                    'https://image.tmdb.org/t/p/w185' +
                                        (snapshot.data! as List)[index]
                                            ['poster_path']),
                              ),
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
            ),
            LocalData(),
          ],
        ),
      ),
    );
  }
}
