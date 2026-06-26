// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get getJoke => 'Get A New Joke';

  @override
  String get noNewJoke => 'No New Joke';

  @override
  String get errorWhileFetching =>
      'Sorry Cannot Load A Joke. \n Check your network Please.';

  @override
  String get lang => 'Language';

  @override
  String get about => 'About Us';

  @override
  String get description =>
      'Smile is a simple joke generator app that lets you browse jokes from JokeAPI,\n Share to your friends and Save your favorites, enjoy a laugh anytime.';

  @override
  String get noFavourite =>
      'No Favourite Jokes yet \n Check som jokes to get your favourites.';

  @override
  String get favourites => 'Favourites';
}
