import 'package:FlutterDemo/provider/saved-suggestions.dart';
import 'package:FlutterDemo/screens/message-detail-screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:FlutterDemo/screens/home-screen.dart';
import 'package:FlutterDemo/screens/saved-suggestion-screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() {
  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.
  Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
    
  runApp(
    ChangeNotifierProvider(
      create: (context) => SavedSuggestions(),
      child: MyApp(),
    )    
  );
}
class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);  

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
      home: HomeScreen(analytics: analytics, observer: observer),
      routes: {
        '/saved-suggestions': (context) => SavedSuggestionsScreen(),
        '/message-detail': (context) => MessageDetailScreen()
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