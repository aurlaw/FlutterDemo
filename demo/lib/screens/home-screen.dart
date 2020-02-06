import 'package:flutter/material.dart';
import 'package:FlutterDemo/screens/randomwords-screen.dart';
import 'package:FlutterDemo/screens/profile-screen.dart';

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
            icon: new Icon(Icons.home),
            title: new Text('Suggestions'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile')
          )
        ],
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
