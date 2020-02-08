import 'package:FlutterDemo/data/suggestions-repository.dart';
// import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class SavedSuggestions extends ChangeNotifier {
  /// Internal, private state of the model.
  Set<String> _items =   Set<String>();
  final SuggestionsRepository _repository = SuggestionsRepository();
  /// An unmodifiable view of the items in the model.
  UnmodifiableSetView<String> get items => UnmodifiableSetView(_items);
  
  SavedSuggestions() {
     load();
  }

  Future load() async{
    var items = await _repository.getAll();
    if(items.length > 0) {
      items.forEach((name) => _items.add(name));
    }
    notifyListeners();

  }
  /// Adds [word] to list.
  Future add(String word) async {
    _items.add(word);
    await _repository.save(word);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
  /// removes [word] to list.
  Future remove(String word) async {
    _items.remove(word);
    await _repository.delete(word);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  bool contains(String word) {
    return _items.contains(word);
  }
}