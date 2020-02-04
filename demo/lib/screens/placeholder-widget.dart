import 'package:flutter/material.dart';

class PlaceholderWidget extends StatelessWidget {
  final Color color;
  final String title;

 PlaceholderWidget({
   @required this.title,
   @required this.color,
  });

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(color: color)
    );   
 }
}