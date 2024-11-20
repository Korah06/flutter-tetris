import 'package:flutter/material.dart';
import 'package:tetris_project/ui/widgets/pixel.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final int rowLength = 10;
  final int columnLength = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: rowLength),
          itemCount: rowLength * columnLength,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return const Pixel(color: Colors.grey);
          }),
    );
  }
}
