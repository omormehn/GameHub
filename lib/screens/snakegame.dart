import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';




class SnakeGame extends StatefulWidget {
  const SnakeGame({super.key, required this.title});

  final String title;

  @override
  State<SnakeGame> createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  static List<int> snakePosition = [45,65,85,105,125];
  int numberOfSquares = 760;
  int score = 0;

  static var randomNumber = Random();
  int food = randomNumber.nextInt(700);
  void generateNewFood() {
    food = randomNumber.nextInt(700);
  }

  void startGame() {
    snakePosition = [45,65,85,105,125];
    const duration = const Duration(milliseconds: 300);
    Timer.periodic(duration, (Timer timer) {
      updateSnake();
      if (gameOver()){
        timer.cancel();
      _showGameOverScreen();
      }
    });
  }

  var direction = 'down';
  void updateSnake() {
    setState(() {
      switch (direction) {
        case 'down':
          if (snakePosition.last > 740) {
            snakePosition.add(snakePosition.last - 760);
          } else {
            snakePosition.add(snakePosition.last + 20);
          }

          break;

        case 'up':
          if (snakePosition.last < 20) {
            snakePosition.add(snakePosition.last - 20 + 760);
          } else {
            snakePosition.add(snakePosition.last - 20);
          }

          break;
        case 'left':
          if (snakePosition.last % 20 == 0) {
            snakePosition.add(snakePosition.last - 1 + 20);
          } else {
            snakePosition.add(snakePosition.last - 1);
          }

          break;
        
        case 'right':
          if ((snakePosition.last + 1) % 20 == 0) {
            snakePosition.add(snakePosition.last + 1 - 20);
          } else {
            snakePosition.add(snakePosition.last + 1);
          }

          break;
      }

      if (snakePosition.last == food) {
        generateNewFood();
        score++;
      } else {
        snakePosition.removeAt(0);
      }
    });
  }

  bool gameOver() {
    for (int i = 0; i < snakePosition.length; i++) {
      int count = 0;
      for (int j = 0; j < snakePosition.length; j++) {
        if (snakePosition[i] == snakePosition[j]) {
          count += 1;
        }
        if (count == 2) {
          return true;
        }
      }
    }
    return false;
  }

  void _showGameOverScreen () {
    showDialog(context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Game Over"),
        content: Text('Your score: $score ' ),
        actions: <Widget> [
          TextButton(
            child: Text('Play Again'),
            onPressed: () {
              startGame();
              Navigator.of(context).pop();
              score = 0;
            },
          )
        ],
      );
    }
    
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[

          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0 && direction != 'up') {
                  direction = 'down';
                } else if (details.delta.dy < 0 && direction != 'down') {
                  direction = 'up';
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0 && direction != 'left') {
                  direction = 'right';
                } else if (details.delta.dx < 0 && direction != 'right') {
                  direction = 'left';
                }
              },
              child: Container(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: numberOfSquares,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 20,
                  ),
                  
                  itemBuilder: (BuildContext context, int index) {
                    if (snakePosition.contains(index)) {
                      return Center(
                        child: Container(
                          padding: EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                              child: Container(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    }
                                       
                  if (index == food) {
                    return Container(
                      padding: EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                          child: Container(color: Colors.blue)),
                    );
                  } else {
                    return Container(
                      padding: EdgeInsets.all(2),
                      child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                        child: Container(color: Colors.grey[900])
                      ),
                    );
                  }
                }),
                
              ),
            ),
          ),
                  
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0,left: 20.0,right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: startGame,
                  child: const Text(
                    'S T A R T',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,

                    ),
                  ),
                ),
                Text(
                  'Score: $score' ,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }

}
   

                 
              
                
  



                    
                            
                          
                      
