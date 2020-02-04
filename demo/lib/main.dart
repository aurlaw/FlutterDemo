import 'package:flutter/material.dart';
import 'package:FlutterDemo/screens/home-screen.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.deepPurple),
      home: HomeScreen()
    );
  }
}
