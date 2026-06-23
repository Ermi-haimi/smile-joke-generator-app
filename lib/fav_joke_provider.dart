import 'dart:collection';

import 'package:flutter/material.dart';

class FavJokeProvider extends ChangeNotifier {
  final List<String> _favJokes = [];

  UnmodifiableListView<String> get favJokes => UnmodifiableListView(_favJokes);

  void toggleFavorite({required String joke}) {
    if (_favJokes.contains(joke)) {
      _favJokes.remove(joke);
    } else {
      _favJokes.add(joke);
    }

    notifyListeners();
  }

  bool isFavorite(String joke) {
    return _favJokes.contains(joke);
  }
}
