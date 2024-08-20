import 'package:flutter/material.dart';

class TheBrick extends StatelessWidget {
  final brickX;
  final brickY;
  final brickHeight;
  final brickWidth;
  final bool isBrickHit; //out of 2

  TheBrick(
      {this.brickWidth,
      this.brickX,
      this.brickHeight,
      this.brickY,
      required this.isBrickHit});

  @override
  Widget build(BuildContext context) {
    return isBrickHit
        ? Container()
        : Container(
            alignment: Alignment((2 * brickX + brickWidth) / (2 - brickWidth), brickY),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Container(
                height: MediaQuery.of(context).size.height * brickHeight / 2,
                width: MediaQuery.of(context).size.width * brickWidth / 2,
                color: Colors.blue.shade700,
              ),
            ),
          );
  }
}
