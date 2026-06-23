import 'dart:collection';

import 'package:flutter/material.dart';

class FavJokeProvider extends ChangeNotifier {
  final List<String> _favJokes = [];

  UnmodifiableListView<String> get favJokes => UnmodifiableListView(_favJokes);

  void addJoke({required String joke}) {
    _favJokes.add(joke);
    notifyListeners();
  }

  void removeJoke({required int ind}) {
    if (ind >= 0) {
      _favJokes.removeAt(ind);
      notifyListeners();
    }
  }
}
