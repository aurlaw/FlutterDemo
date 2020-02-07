import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class SavedSuggestions extends ChangeNotifier {
  /// Internal, private state of the model.
  final Set<WordPair> _items = Set<WordPair>();

  /// An unmodifiable view of the items in the model.
  UnmodifiableSetView<WordPair> get items => UnmodifiableSetView(_items);

  /// Adds [word] to list.
  void add(WordPair word) {
    _items.add(word);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
  /// removes [word] to list.
  void remove(WordPair word) {
    _items.remove(word);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  bool containts(WordPair word) {
    return _items.contains(word);
  }
}