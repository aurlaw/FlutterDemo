import 'package:FlutterDemo/models/analytics-args.dart';
import 'package:FlutterDemo/provider/saved-suggestions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
// import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';

class SavedSuggestionsScreen extends StatelessWidget {
  final _textStyle = const TextStyle(
      fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    final AnalyticsArgs args = ModalRoute.of(context).settings.arguments;
    final analytics = args.analytics;

    var savedModel = Provider.of<SavedSuggestions>(context);
    final Iterable<ListTile> tiles = savedModel.items.map(
      (String item) {
        return ListTile(
          title: Text(item, style: _textStyle),
          onTap: () async {
            await savedModel.remove(item);
            await _sendRemoveEvent(analytics, item);
          },
        );
      },
    );
    final List<Widget> rowData = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Saved Suggestions")),
      body: Container(
          color: Color.fromARGB(255, 79, 158, 99),
          child: ListView(children: rowData)),
    );
  }

  Future<void> _sendRemoveEvent(
      FirebaseAnalytics analytics, String word) async {
    await analytics?.logEvent(
      name: 'remove_suggestion',
      parameters: <String, dynamic>{'word': word},
    );
  }
}
