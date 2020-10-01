// import 'package:FlutterDemo/provider/remote-config.dart';
import 'package:flutter/material.dart';
// import 'package:FlutterDemo/models/user.dart';
// import 'package:FlutterDemo/data/user-repository.dart';
// import 'package:FlutterDemo/bloc/user-bloc.dart';
import 'package:meta/meta.dart';
// import 'package:provider/provider.dart';

class _SettingsStateScreen extends State<SettingsScreen> {
  final _textStyle = const TextStyle(fontSize: 36.0);
  String _title;

  @override
  void initState() {
    _title = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: SafeArea(
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Center(child: Text("Settings TODO", style: _textStyle));
  }
}

class SettingsScreen extends StatefulWidget {
  final String title;
  SettingsScreen({@required this.title});

  @override
  State<StatefulWidget> createState() => _SettingsStateScreen();
}
