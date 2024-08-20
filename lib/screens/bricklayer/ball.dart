import 'package:flutter/material.dart';

class TheBall extends StatelessWidget{
  final ballX;
  final ballY;

  TheBall({this.ballX, this.ballY});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(ballX, ballY),
        child: Container(
          height: 15,
          width: 15,
          
          decoration: BoxDecoration(
            color: Colors.blue.shade900,
            shape: BoxShape.circle,
          ),
        ),
      );
  }
}