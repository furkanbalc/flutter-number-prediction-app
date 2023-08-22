import 'package:flutter/material.dart';
import 'package:sayi_tahmin_app/product/theme/dark_theme.dart';
import 'package:sayi_tahmin_app/product/theme/light_theme.dart';
import 'package:sayi_tahmin_app/view/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tuttum App',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      home: const HomeView(),
    );
  }
}
