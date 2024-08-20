import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOver extends StatelessWidget {
  final isGameOver;
  final resetGame;
  //font
  static var gameFont =GoogleFonts.pressStart2p(
    textStyle: TextStyle(
      color: Colors.blue.shade400, letterSpacing: 0, fontSize: 28
    )
  );

  const GameOver({super.key, required this.isGameOver, this.resetGame});

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Stack(
            children: [
              Container(
                alignment: Alignment(0, -0.3),
                child: Text(
                  'GAME  OVER',
                  style: gameFont,
                  ),
                
              ),
              Container(
                alignment: Alignment(0, 0),
                child: GestureDetector(
                  onTap: resetGame,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.blue,
                      child: Text(
                        'R E S T A R T',
                        style: TextStyle(color: Colors.white)
                      ),
                    ),
                  ),
                  
                
                ),
              ),
            ],
          )
        : Container();
  }
}
