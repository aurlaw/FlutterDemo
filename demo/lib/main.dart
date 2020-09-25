import 'package:FlutterDemo/app-constants.dart';
import 'package:FlutterDemo/provider/remote-config.dart';
import 'package:FlutterDemo/provider/saved-suggestions.dart';
import 'package:FlutterDemo/screens/message-detail-screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
// import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:FlutterDemo/screens/home-screen.dart';
import 'package:FlutterDemo/screens/saved-suggestion-screen.dart';
// import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

void main() async {
  // if (kDebugMode) {
  //   // Force disable Crashlytics collection while doing every day development.
  //   // Temporarily toggle this to true if you want to test crash reporting in your app.
  //   await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  // } else {
  //   // Handle Crashlytics enabled status when not in Debug,
  //   // e.g. allow your users to opt-in to crash reporting.
  //   await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // }
  // // Set `enableInDevMode` to true to see reports while in debug mode
  // // This is only to be used for confirming that reports are being
  // // submitted as expected. It is not intended to be used for everyday
  // // development.
  // // FirebaseCrashlytics.instance.enableInDevMode = false;

  // if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
  //   // Pass all uncaught errors from the framework to Crashlytics.
  //   FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  // }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<SavedSuggestions>(
        create: (context) => SavedSuggestions()),
    ChangeNotifierProvider<RemoteConfiguration>(
        create: (context) => RemoteConfiguration())
  ], child: AppConstants(child: MyApp())));
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
          primaryColor: Color.fromARGB(
              255, 10, 55, 82), //GREEN: Color.fromARGB(255, 16, 82, 33),
          accentColor: Color.fromARGB(255, 56, 28, 94),
          secondaryHeaderColor: Color.fromARGB(200, 0, 71, 117),
          buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
              padding: EdgeInsets.all(16.0),
              buttonColor: Color.fromARGB(255, 56, 28, 94))),
      home: HomeScreen(analytics: analytics, observer: observer),
      routes: {
        AppConstants.of(context).savedSuggestionRoute: (context) =>
            SavedSuggestionsScreen(),
        AppConstants.of(context).messageDetailRoute: (context) =>
            MessageDetailScreen()
      },
    );
  }
}
