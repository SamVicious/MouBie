import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/localScreen.dart';
import 'control/apiFetch.dart';
import 'screens/detailPage.dart';

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
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
      child: new Scaffold(
        body: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                title: Text("News"),
                floating: true,
                pinned: true,
                snap: true,
                bottom: new TabBar(
                  tabs: <Tab>[
                    new Tab(icon: Icon(Icons.home)),
                    new Tab(icon: Icon(Icons.favorite)),
                  ], // <-- total of 2 tabs
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              Container(
                child: Card(
                  child: FutureBuilder(
                    future: addToListFinal(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.data != null) {
                        return CupertinoScrollbar(
                          controller: controller,
                          radius: Radius.circular(20.0),
                          thickness: 5.0,
                          child: ListView.builder(
                              shrinkWrap: true,
                              controller: controller,
                              itemCount: (snapshot.data! as List).length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white38,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade600
                                                  .withOpacity(0.5),
                                              spreadRadius: 7,
                                              blurRadius: 5,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        margin:
                                            EdgeInsets.fromLTRB(10, 0, 10, 20),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: Column(
                                          children: [
                                            Text(
                                              (snapshot.data! as List)[index]
                                                  ['title'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            ClipRRect(
                                              child: FadeInImage.assetNetwork(
                                                  placeholder:
                                                      'assets/images/loading.gif',
                                                  image: (snapshot.data!
                                                              as List)[index]
                                                          ['urlToImage'] ??
                                                      'https://www.wpkube.com/wp-content/uploads/2018/10/404-page-guide-wpk.jpg'),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              (snapshot.data! as List)[index]
                                                  ['description'],
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ContentPage(
                                                (snapshot.data!
                                                    as List)[index]),
                                          ),
                                        );
                                      }),
                                );
                              }),
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
      ),
    );
  }
}
