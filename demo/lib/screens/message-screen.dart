import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
https://medium.com/@ezra_69528/flutter-pinterest-style-photo-grids-b99289584b71
 */