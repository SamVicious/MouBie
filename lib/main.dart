import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'newsBrain.dart';

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
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
    return Scaffold(
      appBar: AppBar(
        title: Text('NewsApp'),
      ),
      body: Container(
        child: Card(
          child: FutureBuilder(
            future: addToListFinal(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return ListView.builder(
                    controller: controller,
                    itemCount: (snapshot.data! as List).length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text((snapshot.data! as List)[index][0]),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                '${(snapshot.data! as List)[index][2] ?? 'https://weakwifisolutions.com/wp-content/uploads/2019/08/error-red-cross-7.png?ezimgfmt=ng%3Awebp%2Fngcb2%2Frs%3Adevice%2Frscb2-1'}'),
                          ),
                          subtitle:
                              Text('${(snapshot.data! as List)[index][1]}'),
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
    );
  }
}

class ContentPage extends StatelessWidget {
  final List individualContent;
  ContentPage(this.individualContent);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(individualContent[0]),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Image(
                image: NetworkImage(individualContent[2] ??
                    'https://www.wpkube.com/wp-content/uploads/2018/10/404-page-guide-wpk.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              individualContent[1],
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
