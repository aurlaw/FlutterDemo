import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:FlutterDemo/provider/native-provider.dart';

class _SettingsStateScreen extends State<SettingsScreen> {
  final _textStyle = const TextStyle(fontSize: 36.0);
  String _title;
  String _content;

  @override
  void initState() {
    _title = widget.title;
    _content = "Settings TODO";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NativeProvider>(context);
    provider.getBatteryLevel();
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: SafeArea(
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Center(child: _getBatteryLevel(context));
  }

  Widget _getBatteryLevel(BuildContext context) {
    return new Consumer<NativeProvider>(
      builder: (context, provider, child) {
        var level = provider.batteryLevel;
        return Text(level != null ? level : _content, style: _textStyle);
      },
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final String title;
  SettingsScreen({@required this.title});

  @override
  State<StatefulWidget> createState() => _SettingsStateScreen();
}
