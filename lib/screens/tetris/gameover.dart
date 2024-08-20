import 'package:flutter/material.dart';

class GameOverWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Game Over!',
          style: TextStyle(fontSize: 36),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Restart the game
          },
          child: Text('Restart'),
        ),
      ],
    );
  }
}
