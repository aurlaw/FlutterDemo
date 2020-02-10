import 'package:FlutterDemo/provider/saved-suggestions.dart';
import 'package:flutter/material.dart';
import 'package:FlutterDemo/screens/home-screen.dart';
import 'package:FlutterDemo/screens/saved-suggestion-screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SavedSuggestions(),
      child: MyApp(),
    )    
  );
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 16, 82, 33), 
        accentColor: Color.fromARGB(255, 56,	28,	94),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary, 
          padding: EdgeInsets.all(16.0),
          buttonColor: Color.fromARGB(255, 56,	28,	94)
          )
        ),
      home: HomeScreen(),
      routes: {
        '/saved-suggestions': (context) => SavedSuggestionsScreen()
      },
    );
  }
}
/*
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

 */