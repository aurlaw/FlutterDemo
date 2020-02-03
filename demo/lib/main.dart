import 'package:flutter/material.dart';
import 'package:FlutterDemo/randomwords.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.deepPurple),
      home: RandomWords(title: 'Flutter Demo',)
    );
  }
}
