import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:package_info/package_info.dart';


class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final String title;
  var _version;

  _RandomWordsState({
    this.title
  });
  
  @override
  void initState() {
      super.initState();
        // This is the proper place to make the async calls
        // This way they only get called once

        // During development, if you change this code,
        // you will need to do a full restart instead of just a hot reload
        
        // You can't use async/await here,
        // We can't mark this method as async because of the @override
      _getVersion().then((version) {
            // If we need to rebuild the widget with the resulting data,
            // make sure to use `setState`      
            setState(() {
              _version = version;
            });
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(),
        backgroundColor: Colors.deepPurple,
      ),
      body: _buildSuggestions(),
    );
  }
  Text _buildTitle() {
    if (_version == null) {
      return new Text(title);
    } else {
      return new Text(title + ' ' + _version);
    }
  }
  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if(i.isOdd) return Divider();

        final index = i ~/2;
        if(index >= _suggestions.length)
        {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      )
    );
  }

  Future<String> _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}

class RandomWords extends StatefulWidget {
  final String title;
  RandomWords({
    this.title
  });

  @override
  _RandomWordsState createState() => _RandomWordsState(title: title);
}