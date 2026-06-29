import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fav_joke_provider.dart';
import 'dart:convert';

class StatisticsProvider extends ChangeNotifier {
  int viewedJokesNum = 0;
  int sharedJokesNum = 0;
  int copiedJokesNum = 0;

  StatisticsProvider() {
    loadStat();
  }

  Map<String, int> categoryView = {};

  Future<void> jokeViewed({required String category}) async {
    final prefs = await SharedPreferences.getInstance();

    viewedJokesNum++;
    categoryView[category] = (categoryView[category] ?? 0) + 1;
    notifyListeners();
    await prefs.setInt("viewedJokesNum", viewedJokesNum);

    final encoded = jsonEncode(categoryView);
    await prefs.setString('categoryView', encoded);
  }

  Future<void> jokeCopied() async {
    final prefs = await SharedPreferences.getInstance();

    copiedJokesNum++;
    await prefs.setInt('copied', copiedJokesNum);
    notifyListeners();
  }

  Future<void> jokeShared() async {
    final prefs = await SharedPreferences.getInstance();
    sharedJokesNum++;
    await prefs.setInt('shared', sharedJokesNum);
    notifyListeners();
  }

  void loadStat() async {
    final prefs = await SharedPreferences.getInstance();

    viewedJokesNum = prefs.getInt('viewedJokesNum') ?? 0;
    copiedJokesNum = prefs.getInt('copied') ?? 0;
    sharedJokesNum = prefs.getInt('shared') ?? 0;

    final jsonString = prefs.getString('categoryView');

    if (jsonString != null) {
      final Map<String, dynamic> decoded = jsonDecode(jsonString);
      categoryView = decoded.map((key, value) => MapEntry(key, value as int));
    }

    notifyListeners();
  }
}
