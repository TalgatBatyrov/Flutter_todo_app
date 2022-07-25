import 'package:flutter/material.dart';

class ThemeModes {
  final lightMode = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.lightBlue[800],
    primarySwatch: Colors.blueGrey,
    fontFamily: 'Georgia',
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'SF Pro Text'),
      headline6: TextStyle(
          fontSize: 16.0,
          fontStyle: FontStyle.normal,
          fontFamily: 'SF Pro Text'),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'SF Pro Text'),
    ),
  );

  final darkMode = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.lightBlue[800],
    primarySwatch: Colors.blueGrey,
    fontFamily: 'Georgia',
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'SF Pro Text'),
      headline6: TextStyle(
          fontSize: 16.0,
          fontStyle: FontStyle.normal,
          fontFamily: 'SF Pro Text'),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'SF Pro Text'),
    ),
  );
}
