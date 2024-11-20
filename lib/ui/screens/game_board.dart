import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris_project/data/piece.dart';
import 'package:tetris_project/data/values.dart';
import 'package:tetris_project/ui/widgets/pixel.dart';

List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(colLength, (j) => null),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Piece currentPiece = Piece(type: Tetromino.values[Random().nextInt(7)]);
  int score = 0;
  bool gameOver = false;

  @override
  void initState() {
    super.initState();

    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();

    Duration frameRate = const Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        clearLines();
        checkLanding();
        if (gameOver) {
          timer.cancel();
          showGameOverDialog();
          return;
        }
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  bool checkCollision(Direction direction) {
    for (int position in currentPiece.position) {
      int row = position ~/ rowLength;
      int col = position % rowLength;
      if (direction == Direction.left) col -= 1;
      if (direction == Direction.right) col += 1;
      if (direction == Direction.down) row += 1;

      if (row >= colLength || col < 0 || col >= rowLength) return true;
      if (row >= 0 && gameBoard[row][col] != null) return true;
    }
    return false;
  }

  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int position in currentPiece.position) {
        int row = position ~/ rowLength;
        int col = position % rowLength;
        if (row >= 0 && col >= 0) gameBoard[row][col] = currentPiece.type;
      }
      createNewPiece();
    }
  }

  void moveLeft() {
    if (checkCollision(Direction.left)) return;
    setState(() {
      currentPiece.movePiece(Direction.left);
    });
  }

  void moveRight() {
    if (checkCollision(Direction.right)) return;
    setState(() {
      currentPiece.movePiece(Direction.right);
    });
  }

  void rotatePiece() {
    if (checkCollision(Direction.right)) return;
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  void createNewPiece() {
    Random rand = Random();
    currentPiece =
        Piece(type: Tetromino.values[rand.nextInt(Tetromino.values.length)]);
    currentPiece.initializePiece();

    if (isGameOver()) {
      gameOver = true;
    }
  }

  void clearLines() {
    for (int row = colLength - 1; row >= 0; row--) {
      bool rowIsFull = true;

      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      if (rowIsFull) {
        for (int i = row; i > 0; i--) {
          for (int j = 0; j < rowLength; j++) {
            gameBoard[i][j] = gameBoard[i - 1][j];
          }
        }
        score += 100;
      }
    }
  }

  bool isGameOver() {
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) return true;
    }
    return false;
  }

  void showGameOverDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Game Over"),
              content: Text("Your score is $score"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {resetGame();});
                  },
                  child: const Text("Play Again"),
                )
              ],
            ));
  }

  void resetGame() {
    gameBoard = List.generate(
      colLength,
      (i) => List.generate(rowLength, (j) => null),
    );
    score = 0;
    gameOver = false;
    createNewPiece();
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowLength),
              itemCount: rowLength * colLength,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                int row = index ~/ rowLength;
                int col = index % rowLength;
                if (currentPiece.position.contains(index)) {
                  return Pixel(
                    color: currentPiece.type.color,
                    child: "",
                  );
                }

                if (gameBoard[row][col] != null) {
                  return Pixel(
                    color: gameBoard[row][col]!.color,
                    child: "",
                  );
                }

                return Pixel(
                  color: Colors.grey[900]!,
                  child: "",
                );
              },
            ),
          ),
          Text(
            "Score: $score",
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 70, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: moveLeft,
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: rotatePiece,
                  icon: const Icon(Icons.rotate_right),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: moveRight,
                  icon: const Icon(Icons.arrow_forward),
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
