import 'package:flutter/material.dart';
import 'package:sayi_tahmin_app/model/user_model.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.user,
    required this.size,
  });

  final UserModel user;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const CircleBorder(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: size,
          ),
          Text(user.userName),
        ],
      ),
    );
  }
}
