import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: Colors.teal,
  accentColor: Colors.tealAccent,
  focusColor: Colors.yellow[400],
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.accent,
    colorScheme: ColorScheme.light().copyWith(
      primary: Colors.cyan[50],
      secondary: Colors.blueGrey[600],
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.teal),
    ),
  ),
  textTheme: TextTheme(
    headline6: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey[900],
    ),
    headline4: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.blueGrey[900],
    ),
    headline2: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.blueGrey[900],
    ),
    bodyText1: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w200,
      color: Colors.blueGrey[200],
    ),
  ),
);
