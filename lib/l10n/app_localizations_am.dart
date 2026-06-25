// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Amharic (`am`).
class AppLocalizationsAm extends AppLocalizations {
  AppLocalizationsAm([String locale = 'am']) : super(locale);

  @override
  String get getJoke => 'አዲስ ቀልድ አግኝ';

  @override
  String get noNewJoke => 'አዲስ ቀልድ የለም';

  @override
  String get errorWhileFetching =>
      'ይቅርታ አዲስ ቀልድ ማግኘት አቻልንም። \n ኔትዎርክዎን ያስተካክሉ።';

  @override
  String get lang => 'ቋንቋ';
}
