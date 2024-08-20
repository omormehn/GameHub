import 'package:flutter/material.dart';
import 'package:treasureguess/screens/tetris/game_board.dart';
import 'package:treasureguess/screens/tetris/gameController.dart';
import 'package:treasureguess/screens/tetris/gameover.dart';
import 'package:treasureguess/screens/tetris/score.dart';


class GameScreen extends StatelessWidget {
  final GameController gameController;

  GameScreen({required this.gameController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tetris'),
      ),
      body: Column(
        children: [
          GameBoardWidget(gameBoard: gameController.gameBoard),
          ScoreWidget(score: gameController.score),
          gameController.gameOver
              ? Expanded(child: GameOverWidget())
              : Container(),
        ],
      ),
    );
  }
}
