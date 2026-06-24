import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavJokeProvider extends ChangeNotifier {
  List<String> _favJokes = [];

  FavJokeProvider() {
    loadFavoriteJokes();
  }

  UnmodifiableListView<String> get favJokes => UnmodifiableListView(_favJokes);

  Future<void> toggleFavorite({required String joke}) async {
    if (_favJokes.contains(joke)) {
      _favJokes.remove(joke);
      await saveJokes();
    } else {
      _favJokes.add(joke);
      await saveJokes();
    }

    notifyListeners();
  }

  Future<void> saveJokes() async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setStringList(
      'favoriteJokes',
      _favJokes,
    );
  }

  bool isFavorite(String joke) {
    return _favJokes.contains(joke);
  }

  Future<void> loadFavoriteJokes() async {
    final sharedPref = await SharedPreferences.getInstance();

    _favJokes = sharedPref.getStringList('favoriteJokes') ?? [];

    notifyListeners();
  }
}
