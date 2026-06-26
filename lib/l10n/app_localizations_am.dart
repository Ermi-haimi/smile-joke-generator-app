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

  @override
  String get about => 'ስለ እኛ';

  @override
  String get description =>
      'Smile ቀላል የቀልድ መተግበሪያ ሲሆን ፤ ቀልዶችን ከJokeAPI ያገኛል ፣ የወደዱትን ለወዳጅዎ በማጋራት እና በማስቀመጥ በማንኛውም ጊዜ መሳቅ ይችላሉ።';

  @override
  String get noFavourite =>
      'ምንም የወደዷቸው ቀልዶች የሉዎትም \n የሚወዱትን ቀልዶች ለማግኘት ቀልዶችን ይመልከቱ።';

  @override
  String get favourites => 'የተወደዱ';
}
