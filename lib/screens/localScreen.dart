import 'package:flutter/material.dart';
import 'package:news_list/control/dataBaseHelper.dart';
import 'DetailPage.dart';

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
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                  itemCount: (snapshot.data!).length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white38,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade600.withOpacity(0.5),
                                spreadRadius: 7,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(
                            children: [
                              Text(
                                (snapshot.data!)[index]['title'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              ClipRRect(
                                child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/images/loading.gif',
                                    image: (snapshot.data!)[index]
                                            ['urlToImage'] ??
                                        'https://www.wpkube.com/wp-content/uploads/2018/10/404-page-guide-wpk.jpg'),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                (snapshot.data!)[index]['description'],
                                style: TextStyle(color: Colors.black54),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ContentPage((snapshot.data!)[index]),
                            ),
                          ).then((value) {
                            setState(() {});
                          });
                        });
                  });
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
