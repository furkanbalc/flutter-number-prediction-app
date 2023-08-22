import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sayi_tahmin_app/product/constants/app_keys.dart';
import 'package:sayi_tahmin_app/view/detail_view.dart';
import 'package:sayi_tahmin_app/widgets/custom_elevated_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<int> numbers = [];

  @override
  void initState() {
    super.initState();
    startNumberSpin();
  }

  void startNumberSpin() {
    numbers.clear();

    for (int i = 0; i < 50; i++) {
      numbers.add(Random().nextInt(100));
    }

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        startNumberSpin();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppKeys.kAppName),
      ),
      body: Stack(
        children: [
          Stack(
            children: numbers
                .map(
                  (number) => Positioned(
                    left: Random().nextInt(MediaQuery.of(context).size.width.toInt()).toDouble(),
                    top: Random().nextInt(MediaQuery.of(context).size.height.toInt()).toDouble(),
                    child: Text(
                      number.toString(),
                      style: const TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          Positioned(
            bottom: 200,
            left: 30,
            right: 30,
            child: CustomElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailView()));
              },
              title: AppKeys.kStartKey,
            ),
          ),
        ],
      ),
    );
  }
}
