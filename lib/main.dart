import 'package:flutter/material.dart';
import 'package:smile/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        top: false,
        child: HomePage(),
      ),
    ),
  );
}
