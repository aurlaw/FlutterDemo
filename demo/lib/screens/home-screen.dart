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
                        new Icon(Icons.notifications, size: 30),
                        new Positioned(right: 0, child:_buildBadge(saved.items.length))
                      ],
                    );
                  },
                )            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            title: Text('Profile')
          )
        ],
     ),            
    );
  }
  Widget _buildBadge(int count) {
    if(count > 0) {
      return _badged(count);
    } else {
      return _empty();
    }

  }
  Widget _empty() {
    return new Container(color: Colors.transparent);
  }
  Widget _badged(int count) {
    return  new Container(
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
    });
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}
