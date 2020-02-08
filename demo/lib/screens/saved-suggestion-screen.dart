import 'package:FlutterDemo/provider/saved-suggestions.dart';
import 'package:flutter/material.dart';
// import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';

class SavedSuggestionsScreen extends StatelessWidget
{
  final _textStyle = const TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    var savedModel = Provider.of<SavedSuggestions>(context); 
    final Iterable<ListTile> tiles = savedModel.items.map(
      (String item) {
        return ListTile(
          title: Text(
            item,
            style: _textStyle
          ),
          onTap: () async {
            await savedModel.remove(item);
          },          
        );
      },
    );
    final List<Widget> rowData = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Suggestions")
      ),
      body: Container(
        color: Color.fromARGB(255, 79,	158,	99), 
        child: ListView(children: rowData)),
    );

  }

}