import 'package:flutter/material.dart';

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();

  return base.copyWith(
    primaryColor: Colors.blue.shade900,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: CircleBorder(),
    ),
  );
}
