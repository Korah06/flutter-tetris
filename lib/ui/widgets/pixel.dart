import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {
  final Color color;
  var child;

  Pixel({super.key, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
          child: Text(
        child.toString(),
        style: const TextStyle(color: Colors.white),
      )),
    );
  }
}
