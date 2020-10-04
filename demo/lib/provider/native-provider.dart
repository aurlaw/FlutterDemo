import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeProvider extends ChangeNotifier {
  static const _platform = const MethodChannel('flutterdemo.dev/native');
  String _batteryLevel = 'Unknown battery level.';
  String get batteryLevel => _batteryLevel;

  // Get battery level.
  Future<void> getBatteryLevel() async {
    try {
      final int result = await _platform.invokeMethod('getBatteryLevel');
      _batteryLevel = 'Battery level at $result% .';
    } catch (e) {
      print(e);
      _batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
