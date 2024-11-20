import 'package:flutter/material.dart';

enum Tetromino {
  L(Colors.orange),
  J(Colors.blueAccent),
  I(Colors.yellow),
  O(Colors.pink),
  S(Colors.green),
  Z(Colors.red),
  T(Colors.purple);

  final Color color;

  const Tetromino(this.color);
}

enum Direction { left, right, down }

const int rowLength = 10;
const int colLength = 15;
