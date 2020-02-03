import 'package:flutter/material.dart';
import 'package:FlutterDemo/randomwords.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: RandomWords(title: 'Flutter Demo',)
    );
  }
}
