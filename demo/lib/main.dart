import 'package:flutter/material.dart';
import 'package:FlutterDemo/screens/home-screen.dart';
import 'package:FlutterDemo/screens/saved-suggestion-screen.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.deepPurple, 
        accentColor: Colors.blueAccent,
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary, 
          padding: EdgeInsets.all(16.0),
          buttonColor: Colors.blueAccent
          )
        ),
      // home: HomeScreen()
      routes: {
        '/': (context) => HomeScreen(),
        '/saved-suggestions': (context) => SavedSuggestionsScreen()
      },
    );
  }
}