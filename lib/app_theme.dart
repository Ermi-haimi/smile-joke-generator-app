import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: Colors.blue,
    appBarTheme: AppBarThemeData(
      backgroundColor: Color(0xFFced4da),
    ),

    scaffoldBackgroundColor: Color(0xfff8f9fa),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF6c757d),
        foregroundColor: Color(0xffffffff),
      ),
    ),
    cardTheme: CardThemeData(
      color: Color(0xFFadb5bd),
      shadowColor: Color(0xFFe9ecef),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: Color(0xff000000),
      ),
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: Color(0xff012a4a),
      ),
      labelLarge: TextStyle(
        color: Color(0xffffffff),
        fontWeight: FontWeight.w700,
        fontSize: 25,
      ),
      titleSmall: TextStyle(
        color: Colors.black,
      ),
      titleLarge: TextStyle(
        color: Colors.black,
      ),
    ),

    chipTheme: ChipThemeData(
      selectedColor: Color(0xFFadb5bd),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.blue,
    appBarTheme: AppBarThemeData(backgroundColor: Color(0xff343a40)),

    scaffoldBackgroundColor: Color(0xff212529),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff495057),
      ),
    ),

    cardTheme: CardThemeData(
      color: Color(0xff141414),
    ),

    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: Color(0xffffffff),
      ),
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: Color(0xffffffff),
      ),
      labelLarge: TextStyle(
        color: Color(0xffffffff),
        fontWeight: FontWeight.w700,
        fontSize: 25,
      ),
      titleSmall: TextStyle(
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        color: Colors.white,
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: Color(0xff495057),
      selectedColor: Color(0xff6c757d),
    ),
  );
}
