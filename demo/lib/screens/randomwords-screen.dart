import 'package:FlutterDemo/app-constants.dart';
import 'package:FlutterDemo/components/sliver-bar-replacement.dart';
import 'package:FlutterDemo/models/analytics-args.dart';
import 'package:FlutterDemo/provider/saved-suggestions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:package_info/package_info.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

class RandomWordsScreen extends StatelessWidget {
  final _suggestions = <WordPair>[];
  final _textStyle = const TextStyle(fontSize: 18.0);
  final String title;
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  RandomWordsScreen({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.list),
                  onPressed: () {
                    _pushSaved(context);
                  }),
            ],
            expandedHeight: 220.0,
            primary: true,
            floating: false,
            pinned: true,
            snap: false,
            stretch: true,
            elevation: 50,
            centerTitle: true,
            title: SliverBarReplacement(builder: (context, visible, extent) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final offsetAnimation = Tween<Offset>(
                          begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                      .animate(animation);
                  return ClipRect(
                      child: SlideTransition(
                          child: child, position: offsetAnimation));
                },
                child: visible ? _buildCombinedTitle() : _buildTitle(),
              );
            }),
            flexibleSpace: FlexibleSpaceBar(
                stretchModes: <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                centerTitle: true,
                title:
                    SliverBarReplacement(builder: (context, visible, extent) {
                  return Visibility(child: _buildSubtitle(), visible: !visible);
                }),
                background: Image.network(
                  'https://assets-us-01.kc-usercontent.com/c7f41139-7a47-005e-59d5-3261d7bc8ecf/57b4ba67-3d7b-4960-9a64-2785329a2816/gustav_patio.jpg',
                  fit: BoxFit.cover,
                  color: Theme.of(context).primaryColor,
                  colorBlendMode: BlendMode.colorDodge,
                )),
          ),
          new SliverList(delegate: _buildSuggestionsDelete(context)),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(title);
  }

  Widget _buildSubtitle() {
    return FutureBuilder<String>(
      future: _getVersion(),
      builder: (context, snapshot) {
        String titleStr = '';
        if (snapshot.hasData) {
          titleStr += 'Flutter Demo ' + snapshot.data;
        }
        return Text(
          titleStr,
          style: _textStyle,
        );
      },
    );
  }

  Widget _buildCombinedTitle() {
    return FutureBuilder<String>(
      future: _getVersion(),
      builder: (context, snapshot) {
        String titleStr = title;
        if (snapshot.hasData) {
          titleStr += '-' + snapshot.data;
        }
        return Text(titleStr);
      },
    );
  }

  SliverChildDelegate _buildSuggestionsDelete(BuildContext context) {
    var savedModel = Provider.of<SavedSuggestions>(context);
    return SliverChildBuilderDelegate((context, i) {
      if (i.isOdd) return Divider();

      final index = i ~/ 2;
      if (index >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10));
      }
      return _buildRow(context, _suggestions[index], savedModel);
    });
  }

  Widget _buildRow(
      BuildContext context, WordPair pair, SavedSuggestions savedModel) {
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
        var word = pair.asPascalCase;
        if (alreadySaved) {
          await savedModel.remove(word);
          await _sendRemoveEvent(word);
        } else {
          await savedModel.add(word);
          await _sendSaveEvent(word);
        }
      },
    );
  }

  void _pushSaved(BuildContext context) {
    Navigator.pushNamed(context, AppConstants.of(context).savedSuggestionRoute,
        arguments: AnalyticsArgs(analytics, observer));
    observer.analytics.setCurrentScreen(
      screenName: AppConstants.of(context).savedSuggestionRoute,
    );
  }

  Future<void> _sendSaveEvent(String word) async {
    await analytics.logEvent(
      name: 'save_suggestion',
      parameters: <String, dynamic>{'word': word},
    );
  }

  Future<void> _sendRemoveEvent(String word) async {
    await analytics.logEvent(
      name: 'remove_suggestion',
      parameters: <String, dynamic>{'word': word},
    );
  }

  Future<String> _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version}(${packageInfo.buildNumber})';
  }
}
/*
References for sliver:
https://www.woolha.com/tutorials/flutter-sliverappbar-examples
https://api.flutter.dev/flutter/material/SliverAppBar-class.html
https://stackoverflow.com/questions/54973948/is-it-possible-to-use-listview-builder-inside-of-customscrollview
https://api.flutter.dev/flutter/material/FlexibleSpaceBar-class.html

 */
