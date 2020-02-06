import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:FlutterDemo/models/suggestions.dart';

class SavedSuggestionsScreen extends StatelessWidget
{
  final _textStyle = const TextStyle(fontSize: 18.0, color: Colors.white);

  @override
  Widget build(BuildContext context) {

    final Suggestions _savedSuggestions = ModalRoute.of(context).settings.arguments;
    final Iterable<ListTile> tiles = _savedSuggestions.items.map(
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
        title: Text(_savedSuggestions.title)
      ),
      body: Container(color: Colors.blue, child: ListView(children: rowData)),
    );

  }
}