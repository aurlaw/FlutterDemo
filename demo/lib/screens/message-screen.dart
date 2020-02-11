import 'dart:math';

import 'package:FlutterDemo/models/message.dart';
import 'package:FlutterDemo/services/message-service.dart';
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
        body: FutureBuilder<List<Message>>(
          future: _getMessages(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return _buildMessages(snapshot.data);
            }
            if(snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text("Error"));
            }
            return _buildLoading();
          },
        ),
      );
  }

  Future<List<Message>> _getMessages() async {
      MessageService service = MessageService();
      return await service.getMessages();
  }
  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildMessages(List<Message> messageList) {
    var tiles = messageList.map((m) => _ImageTile(message: m,)).toList();
    return new Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: new StaggeredGridView.count(
              crossAxisCount: 4,
              staggeredTiles: _getStaggeredTiles(messageList.length),
              children: tiles,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              padding: const EdgeInsets.all(4.0),
            )
          );
  }

  List<StaggeredTile> _getStaggeredTiles(int count) {
    final List<StaggeredTile> tiles = [];
    var rnd = Random();
    int x = 0;
    while (x < count) {
      tiles.add(StaggeredTile.count(rnd.nextInt(3) +1, rnd.nextInt(3) +1));
      x++;
    }
    return tiles;
  }
}

class _ImageTile extends StatelessWidget {
  final Message message;
  const _ImageTile({
    @required this.message,
  });


  @override
  Widget build(BuildContext context) {
    return new Card(
      color: const Color(0x00000000),      
      elevation: 3.0,
      child: new GestureDetector(
        onTap: () {
          print(message.content);
          Navigator.pushNamed(context, '/message-detail', arguments: message);
        },
        child: new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new NetworkImage(message.imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
            )
        ),
      ),
    );
  }
}

/*
Navigator.pushNamed(context, '/saved-suggestions', 
                          arguments: suggestions );


https://medium.com/@ezra_69528/flutter-pinterest-style-photo-grids-b99289584b71
 */