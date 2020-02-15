import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class RemoteConfiguration extends ChangeNotifier {
  RemoteConfig remoteConfig;

  RemoteConfiguration() {
    init();
  }

  Future init() async {
    remoteConfig = await RemoteConfig.instance;
    await activate();
  }

  Future activate() async {
    await remoteConfig.fetch(expiration: const Duration(hours: 5));
    await remoteConfig.activateFetched();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  Future setDefaults(String key, dynamic value) async {
    await remoteConfig.setDefaults(<String, dynamic>{key: value});
  }

  String getProfileMessage() {
    // await activate();
    // print('getProfileMessage');
    return remoteConfig?.getString("profile_message");
  }
}
