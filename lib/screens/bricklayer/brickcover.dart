import 'package:flutter/material.dart';

class BrickCover extends StatelessWidget {
  final bool hasGameStarted;

  const BrickCover({super.key, required this.hasGameStarted});

  @override
  Widget build(BuildContext context) {
    // If game has started display en empty container, else display tap to play
    return hasGameStarted 
      ? Container()
    : Container(
      alignment: Alignment(0, -0.2),
      child: Text(
        'Start!',
        style: TextStyle(
          color: Colors.blue.shade800,
        ),
      ),
    );
    
  }
}