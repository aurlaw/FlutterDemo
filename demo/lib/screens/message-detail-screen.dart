import 'package:FlutterDemo/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class MessageDetailScreen extends StatelessWidget {
  final _textStyle = const TextStyle(
      fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w500);

  MessageDetailScreen();

  @override
  Widget build(BuildContext context) {
    final Message message = ModalRoute.of(context).settings.arguments;
    String content = "";
    if (message.title != null) {
      content = "<h1>${message.title}</h1>";
    }
    content += message.content;
    return Scaffold(
        appBar: AppBar(title: Text("Message Detail")),
        body: Container(
            child: Padding(
          padding: EdgeInsets.all(0),
          child: SingleChildScrollView(
              primary: true,
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Image.network(message.imageUrl),
                  Html(
                    data: content,
                    // defaultTextStyle: _textStyle,
                    // padding: EdgeInsets.all(8.0),
                  )
                  // Text(message.content, style: _textStyle)
                ],
              )),
        )));
  }
}
