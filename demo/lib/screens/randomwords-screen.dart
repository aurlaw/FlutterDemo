import 'package:FlutterDemo/provider/saved-suggestions.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:package_info/package_info.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

class RandomWordsScreen extends StatelessWidget {
  final _suggestions = <WordPair>[];
  final _textStyle = const TextStyle(fontSize: 18.0);
  final String title;

  RandomWordsScreen({
    @required this.title
  });
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: () {
            _pushSaved(context);
          }),
        ],
      ),
      body: _buildSuggestions(context),
    );
  }
  Widget _buildTitle() {
    return FutureBuilder<String>(
      future: _getVersion(),
      builder: (context, snapshot) {
        String titleStr = title;
        if(snapshot.hasData) {
          titleStr += ' ' + snapshot.data;
        }
        return Text(titleStr);
      },
    );
  }
  
  Widget _buildSuggestions(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if(i.isOdd) return Divider();

        final index = i ~/2;
        if(index >= _suggestions.length)
        {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(context, _suggestions[index]);
      },
    );
  }

  Widget _buildRow(BuildContext context, WordPair pair) {
    var savedModel = Provider.of<SavedSuggestions>(context); 
    var alreadySaved = savedModel.containts(pair);
    
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _textStyle,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
          if(alreadySaved) {
            savedModel.remove(pair);
          } else {
            savedModel.add(pair);
          }
      },
    );
  }

  void _pushSaved(BuildContext context) {
    Navigator.pushNamed(context, '/saved-suggestions'); 

  }
  
  Future<String> _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}