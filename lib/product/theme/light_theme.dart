import 'package:flutter/material.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    primaryColor: Colors.lightBlue.shade50,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.lightBlue.shade50,
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
