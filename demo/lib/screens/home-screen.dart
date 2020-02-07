import 'package:FlutterDemo/provider/saved-suggestions.dart';
import 'package:flutter/material.dart';
import 'package:FlutterDemo/screens/randomwords-screen.dart';
import 'package:FlutterDemo/screens/profile-screen.dart';
import 'package:provider/provider.dart';

class _HomeScreenState extends State<HomeScreen> {
   int _currentIndex = 0;
  final List<Widget> _children = [
    RandomWordsScreen(title: "Random Suggestions"),
    ProfileScreen(title: "Profile")
    // PlaceholderWidget(title: "Profile", color: Colors.blue),
  ];
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, 
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            title: new Text('Suggestions'),
            icon: 
                Consumer<SavedSuggestions>(
                  builder: (context, saved, child) {
                    return new Stack(
                      children: <Widget>[
                        new Icon(Icons.notifications),
                        new Positioned(
                          right: 0,
                          child: new Container(
                            padding: EdgeInsets.all(1),
                            decoration: new BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            child: new Text(
                              '${saved.items.length}',
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                )            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile')
          )
        ],
     ),            
    );
  }
/*
   new BottomNavigationBarItem(
        title: new Text('Home'),
        icon: new Stack(
          children: <Widget>[
            new Icon(Icons.home),
            new Positioned(  // draw a red marble
              top: 0.0,
              right: 0.0,
              child: new Icon(Icons.brightness_1, size: 8.0, 
                color: Colors.redAccent),
            )
          ]
        ),
      )

 */

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}
