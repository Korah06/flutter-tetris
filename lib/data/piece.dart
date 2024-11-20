import 'package:tetris_project/data/values.dart';

class Piece {
  final Tetromino type;

  List<int> position = [];

  Piece({required this.type});

  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [-26, -16, -6, -5];
        break;
      case Tetromino.J:
        position = [-25, -15, -5, -6];
        break;
      case Tetromino.I:
        position = [-36, -26, -16, -6];
        break;
      case Tetromino.O:
        position = [-15, -16, -5, -6];
        break;
      case Tetromino.S:
        position = [-24, -25, -15, -16];
        break;
      case Tetromino.Z:
        position = [-14, -15, -25, -26];
        break;
      case Tetromino.T:
        position = [-5, -14, -15, -16];
        break;
    }
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.left:
        position = position.map((e) => e - 1).toList();
        break;
      case Direction.right:
        position = position.map((e) => e + 1).toList();
        break;
      case Direction.down:
        position = position.map((e) => e + rowLength).toList();
        break;
    }
  }
}
