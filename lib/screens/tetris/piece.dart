import 'package:treasureguess/screens/tetris/values.dart';




class Piece {
  Tetromino type;
  List<List<int>> shape;
  List<int> position = [];

  Piece({required this.type});

  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        shape = [
          [0, 1],
          [0, 1],
          [1, 1],
        ];
        position = [4, 14, 24, 25];
        break;
      // Add more cases for other Tetriminos
    }
  }

  void rotate() {
    List<List<int>> newShape = List.generate(
      shape[0].length,
      (i) => List.generate(shape.length, (j) => shape[j][i]),
    );

    for (int i = 0; i < newShape.length; i++) {
      for (int j = 0; j < newShape[i].length; j++) {
        newShape[i][j] = shape[newShape.length - 1 - j][i];
      }
    }

    shape = newShape;
    updatePosition();
  }

  void updatePosition() {
    position.clear();
    for (int i = 0; i < shape.length; i++) {
      for (int j = 0; j < shape[i].length; j++) {
        if (shape[i][j] == 1) {
          position.add(i * 10 + j + 4);
        }
      }
    }
  }
}

// class Piece {
//   //TYPE OF TETRIS PIECE

//   Tetromino type;

//   Piece({required this.type});


//   List<int> position = [];


//   void initializePiece() {
//     switch (type) {
//       case Tetromino.L:
//       position = [
//         4,14,24,25
//       ];
//       break;
//     }
//   }
// }