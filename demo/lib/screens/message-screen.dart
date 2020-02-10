import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  final String title;

  MessageScreen({
    @required this.title
  });

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Container(color: Colors.blueGrey),
      );
  }
}

/*
https://stackoverflow.com/questions/50706500/flutter-how-to-make-an-array-with-the-json-data

 */