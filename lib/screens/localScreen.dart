import 'package:flutter/material.dart';
import 'package:news_list/control/dataBaseHelper.dart';
import 'detailPage.dart';

class LocalData extends StatefulWidget {
  const LocalData({Key? key}) : super(key: key);

  @override
  _LocalDataState createState() => _LocalDataState();
}

class _LocalDataState extends State<LocalData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: FutureBuilder(
          future: DatabaseHelper.instance.queryAll(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                  itemCount: (snapshot.data! as List).length,
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
                                (snapshot.data! as List)[index]['title'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              ClipRRect(
                                child: Image.network((snapshot.data!
                                        as List)[index]['urlToImage'] ??
                                    'https://www.wpkube.com/wp-content/uploads/2018/10/404-page-guide-wpk.jpg'),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                (snapshot.data! as List)[index]['description'],
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
                                  ContentPage((snapshot.data! as List)[index]),
                            ),
                          );
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
