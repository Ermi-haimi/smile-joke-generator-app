import 'package:flutter/material.dart';
import 'package:smile/app_theme.dart';
import 'package:smile/fav_joke_provider.dart';
import 'package:smile/home_page.dart';
import 'package:provider/provider.dart';
import 'package:smile/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FavJokeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      themeMode: themeProvider.themeMode,

      home: const HomePage(),
    );
  }
}
