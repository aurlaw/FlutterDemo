import 'package:FlutterDemo/provider/saved-suggestions.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';

class SavedSuggestionsScreen extends StatelessWidget
{
  final _textStyle = const TextStyle(fontSize: 18.0, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    var savedModel = Provider.of<SavedSuggestions>(context); 
    final Iterable<ListTile> tiles = savedModel.items.map(
      (WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _textStyle
          ),
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
      body: Container(color: Colors.blue, child: ListView(children: rowData)),
    );

  }
}