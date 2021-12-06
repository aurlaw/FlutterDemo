import 'package:FlutterDemo/provider/saved-suggestions.dart';
import 'package:FlutterDemo/screens/message-screen.dart';
import 'package:FlutterDemo/screens/settings-screen.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:FlutterDemo/screens/randomwords-screen.dart';
import 'package:FlutterDemo/screens/profile-screen.dart';

import 'package:provider/provider.dart';

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  // final FirebaseAnalytics analytics;
  // final FirebaseAnalyticsObserver observer;

  _HomeScreenState();
  int _currentIndex = 0;
  final List<Widget> _children = [
    RandomWordsScreen(title: "Random Suggestions"),
    ProfileScreen(title: "Profile"),
    MessageScreen(title: "Messages"),
    SettingsScreen(title: "Settings")
    // PlaceholderWidget(title: "Profile", color: Colors.blue),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
              label: "Suggestions",
              icon: Consumer<SavedSuggestions>(
                builder: (context, saved, child) {
                  return new Stack(
                    children: <Widget>[
                      new Icon(Icons.notifications, size: 30),
                      new Positioned(
                          right: 0, child: _buildBadge(saved.items.length))
                    ],
                  );
                },
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30), label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(Icons.message, size: 30), label: "Messages"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 30), label: "Settings")
        ],
      ),
    );
  }

  Widget _buildBadge(int count) {
    if (count > 0) {
      return _badged(count);
    } else {
      return _empty();
    }
  }

  Widget _empty() {
    return new Container(color: Colors.transparent);
  }

  Widget _badged(int count) {
    return new Container(
      padding: EdgeInsets.all(2),
      decoration: new BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(6),
      ),
      constraints: BoxConstraints(
        minWidth: 15,
        minHeight: 15,
      ),
      child: new Text(
        '$count',
        style: new TextStyle(
          color: Colors.white,
          fontSize: 9,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _sendCurrentTabToAnalytics();
    });
  }

  void _sendCurrentTabToAnalytics() {
    // observer.analytics.setCurrentScreen(
    //   screenName: 'HomeScreen/$_currentIndex',
    // );
    print('screen event sent');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // observer.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    // observer.unsubscribe(this);
    super.dispose();
  }
}

class HomeScreen extends StatefulWidget {
  // final FirebaseAnalytics analytics;
  // final FirebaseAnalyticsObserver observer;

  HomeScreen();

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}
