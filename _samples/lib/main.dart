import 'package:flutter/material.dart';
import 'package:navigate/pages/first.dart';
import 'package:navigate/pages/product-detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => FirstPage(),
        '/product-info': (context) => ProductDetail()
      },
    );
  }
}
