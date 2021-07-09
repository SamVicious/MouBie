import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_list/control/dataBaseHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ContentPage extends StatefulWidget {
  final Map<String, dynamic> individualContent;
  ContentPage(this.individualContent);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  var isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.individualContent['title']),
      ),
      body: Container(
        child: Column(
          children: [
            Image(
              image: NetworkImage(widget.individualContent['urlToImage'] ??
                  'https://www.wpkube.com/wp-content/uploads/2018/10/404-page-guide-wpk.jpg'),
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              widget.individualContent['description'],
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (widget.individualContent['_id'] == null) {
            await DatabaseHelper.instance.insert({
              DatabaseHelper.title: widget.individualContent['title'],
              DatabaseHelper.description:
                  widget.individualContent['description'],
              DatabaseHelper.imageURL: widget.individualContent['urlToImage'] ??
                  'https://www.wpkube.com/wp-content/uploads/2018/10/404-page-guide-wpk.jpg',
              DatabaseHelper.state: 1,
            });
            Fluttertoast.showToast(
                msg: "Added to Fav",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            await DatabaseHelper.instance
                .delete(widget.individualContent['_id']);
            Fluttertoast.showToast(
                msg: "Removed content",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pop(context);
          }
          setState(() {
            isPressed = !isPressed;
          });
        },
        child: Icon(
          Icons.favorite,
          color: !isPressed || widget.individualContent['state'] == 1
              ? Colors.white
              : Colors.red[400],
        ),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
