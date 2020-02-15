import 'package:flutter/material.dart';

// Application Constants
class AppConstants extends InheritedWidget {

  static AppConstants of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<AppConstants>();

  const AppConstants({Widget child, Key key}):super(key:key, child: child);

  final String savedSuggestionRoute = "/saved-suggestions";
  final String messageDetailRoute = "/message-detail";

  @override
  bool updateShouldNotify(AppConstants oldWidget) => false;

}



/*
USAGE:
AppConstants.of(context).savedSuggestionRoute
 */