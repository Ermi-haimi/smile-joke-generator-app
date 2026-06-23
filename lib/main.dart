import 'package:flutter/material.dart';
import 'package:smile/fav_joke_provider.dart';
import 'package:smile/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FavJokeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          top: false,
          child: HomePage(),
        ),
      ),
    ),
  );
}
