import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class RemoteConfiguration extends ChangeNotifier {
  final RemoteConfig remoteConfig;

  RemoteConfiguration({this.remoteConfig});

  Future activate() async {
    await remoteConfig.fetch(expiration: const Duration(hours: 5));
    await remoteConfig.activateFetched();
  }
  Future setDefaults(String key, dynamic value) async {
    await remoteConfig.setDefaults(<String, dynamic>{key: value});
  }

  Future<String> getProfileMessage() async {
    await activate();
    return remoteConfig.getString("profile_message");
  }
}
