import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tetris_project/data/piece.dart';
import 'package:tetris_project/data/values.dart';
import 'package:tetris_project/ui/widgets/pixel.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Piece? currentPiece = Piece(type: Tetromino.T);

  @override
  void initState() {
    super.initState();

    startGame();
  }

  void startGame() {
    currentPiece!.initializePiece();

    Duration frameRate = const Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        currentPiece!.movePiece(Direction.down);
      });
    });
  }

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
            if (currentPiece!.position.contains(index)) {
              return Pixel(
                color: Colors.blueAccent,
                child: index,
              );
            } else {
              return Pixel(
                color: Colors.grey[900]!,
                child: index,
              );
            }
          }),
    );
  }
}
