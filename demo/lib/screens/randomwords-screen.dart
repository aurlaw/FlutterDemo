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
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                actions: <Widget>[
                  IconButton(icon: Icon(Icons.list), onPressed: () {
                    _pushSaved(context);
                  }),],
                expandedHeight: 220.0,
                primary: true,
                floating: false,
                pinned: true,
                snap: false,
                stretch: true,
                elevation: 50,
                centerTitle: true,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: <StretchMode>[
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                    StretchMode.fadeTitle,
                  ],                  
                    centerTitle: true,
                    title: _buildTitle(),
                    // background: Container(color:Theme.of(context).primaryColor)
                   background: Image.network(
                      'https://assets-us-01.kc-usercontent.com/c7f41139-7a47-005e-59d5-3261d7bc8ecf/cd40fc54-760c-4190-9f1b-3d07d0870cd9/ireland_waterford_castle.jpg',
                      fit: BoxFit.cover,
                      color: Theme.of(context).primaryColor,
                      colorBlendMode: BlendMode.hardLight,
                    )
                  ),
              ),
              new SliverList(
                  delegate: _buildSuggestionsDelete(context)
              ),
            ],
          ),
    );
  }
  Widget _buildTitle() {
    return FutureBuilder<String>(
      future: _getVersion(),
      builder: (context, snapshot) {
        String titleStr = title;
        if(snapshot.hasData) {
          titleStr += ' v.' + snapshot.data;
        }
        return Text(titleStr);
      },
    );
  }
  
  // Widget _buildSuggestions(BuildContext context) {
  //   var savedModel = Provider.of<SavedSuggestions>(context); 
  //   return ListView.builder(
  //     padding: const EdgeInsets.all(16.0),
  //     itemBuilder: (context, i) {
  //       if(i.isOdd) return Divider();

  //       final index = i ~/2;
  //       if(index >= _suggestions.length)
  //       {
  //         _suggestions.addAll(generateWordPairs().take(10));
  //       }
  //       return _buildRow(context, _suggestions[index], savedModel);
  //     },
  //   );
  // }

  SliverChildDelegate _buildSuggestionsDelete(BuildContext context) {
    var savedModel = Provider.of<SavedSuggestions>(context); 
    return SliverChildBuilderDelegate((context, i) {
      if(i.isOdd) return Divider();

      final index = i ~/2;
      if(index >= _suggestions.length)
      {
        _suggestions.addAll(generateWordPairs().take(10));
      }
      return _buildRow(context, _suggestions[index], savedModel);
    });
  }


  Widget _buildRow(BuildContext context, WordPair pair, SavedSuggestions savedModel) {
    var alreadySaved = savedModel.contains(pair.asPascalCase);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _textStyle,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () async {
        // print(pair.asPascalCase);
        // print(alreadySaved);
          if(alreadySaved) {
            await savedModel.remove(pair.asPascalCase);
          } else {
            await savedModel.add(pair.asPascalCase);
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
/*
References for sliver:
https://www.woolha.com/tutorials/flutter-sliverappbar-examples
https://api.flutter.dev/flutter/material/SliverAppBar-class.html
https://stackoverflow.com/questions/54973948/is-it-possible-to-use-listview-builder-inside-of-customscrollview
https://api.flutter.dev/flutter/material/FlexibleSpaceBar-class.html

 */