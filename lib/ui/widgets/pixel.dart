import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {
  final Color color;

  const Pixel({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
