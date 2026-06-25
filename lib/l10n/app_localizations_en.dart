// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get getJoke => 'Get Joke';

  @override
  String get noNewJoke => 'No New Joke';

  @override
  String get errorWhileFetching =>
      'Sorry Cannot Load A Joke. \n Check your network Please.';

  @override
  String get lang => 'Language';
}
