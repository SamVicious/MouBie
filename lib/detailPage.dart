import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ContentPage extends StatefulWidget {
  final List individualContent;
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
        title: Text(widget.individualContent[0]),
      ),
      body: Container(
        child: Column(
          children: [
            Image(
              image: NetworkImage(widget.individualContent[2] ??
                  'https://www.wpkube.com/wp-content/uploads/2018/10/404-page-guide-wpk.jpg'),
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              widget.individualContent[1],
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.favorite,
          color: isPressed ? Colors.red[300] : Colors.white,
        ),
        backgroundColor: Colors.grey,
        onPressed: () => setState(() => isPressed = !isPressed),
      ),
    );
  }
}
