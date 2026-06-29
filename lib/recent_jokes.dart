class RecentJokes {
  final List<String> _recentJokes = [];
  int _index = -1;

  String getNextJoke() {
    _increment();
    return _recentJokes[_index];
  }

  String getPrevJoke() {
    _decrement();
    return _recentJokes[_index];
  }

  void addJoke({required String joke}) {
    _recentJokes.add(joke);
    _index = _recentJokes.length - 1;
  }

  bool hasNext() {
    if (_index < _recentJokes.length - 1) {
      return true;
    }
    return false;
  }

  bool hasPrev() {
    if (_index > 0) {
      return true;
    }
    return false;
  }

  void _increment() {
    if (_index < _recentJokes.length - 1) {
      _index++;
    }
  }

  void _decrement() {
    if (_index > 0) {
      _index--;
    }
  }
}
