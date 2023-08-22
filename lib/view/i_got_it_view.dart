import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sayi_tahmin_app/model/user_model.dart';
import 'package:sayi_tahmin_app/product/constants/app_keys.dart';
import 'package:sayi_tahmin_app/view/guessing_view.dart';

class IGotItView extends StatefulWidget {
  const IGotItView({super.key, required this.min, required this.max, required this.users});
  final int min;
  final int max;
  final List<UserModel> users;

  @override
  State<IGotItView> createState() => _IGotItViewState();
}

class _IGotItViewState extends State<IGotItView> {
  List<int> numbers = [];

  @override
  void initState() {
    super.initState();
    startNumberSpin();
  }

  void startNumberSpin() {
    numbers.clear();

    for (int i = 0; i < 100; i++) {
      numbers.add(Random().nextInt(widget.max) + widget.min);
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
                    child: InkWell(
                      onTap: () {
                        _showAlertDialog(context, number);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          number.toString(),
                          style: const TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  void _showAlertDialog(BuildContext context, int number) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'TUTTUN!',
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                number.toString(),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const Text(
                'Devam Et ve telefonu arkadaşlarına ver.',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GuessingView(
                      answer: number,
                      users: widget.users,
                    ),
                  ),
                );
              },
              child: const Text('Devam Et'),
            ),
          ],
        );
      },
    );
  }
}
