import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'newsBrain.dart';
import 'detailPage.dart';

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = ScrollController();
  int i = 1;
  List<List> finalList = [];
  Future addToListFinal() async {
    List<List> newsContent = await Data().addToList(number: i);
    return newsContent;
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(listenScrolling);
  }

  void listenScrolling() {
    if (controller.position.atEdge) {
      final isTop = controller.position.pixels == 0;
      if (isTop) {
        if (i > 1) {
          i--;
          setState(() {});
        }
      } else {
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
                      return ListView.builder(
                          controller: controller,
                          itemCount: (snapshot.data! as List).length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white38,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade600
                                            .withOpacity(0.5),
                                        spreadRadius: 7,
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        (snapshot.data! as List)[index][0],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      ClipRRect(
                                        child: Image.network((snapshot.data!
                                                as List)[index][2] ??
                                            'https://www.wpkube.com/wp-content/uploads/2018/10/404-page-guide-wpk.jpg'),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Text(
                                        (snapshot.data! as List)[index][1],
                                        style: TextStyle(color: Colors.black54),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ContentPage(
                                            (snapshot.data! as List)[index])),
                                  );
                                });
                          });
                    } else {
                      return Container(
                        child: Center(
                          child: Text('Loading'),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
