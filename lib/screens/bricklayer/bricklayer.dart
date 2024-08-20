import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:treasureguess/screens/bricklayer/ball.dart';
import 'package:treasureguess/screens/bricklayer/brick.dart';
import 'package:treasureguess/screens/bricklayer/brickcover.dart';
import 'package:treasureguess/screens/bricklayer/gameoverscreen.dart';
import 'package:treasureguess/screens/bricklayer/player.dart';

class BricklayerGame extends StatefulWidget {
  const BricklayerGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BricklayerGameState createState() => _BricklayerGameState();
}

// ignore: camel_case_types, constant_identifier_names
enum direction { UP, DOWN, LEFT, RIGHT }

class _BricklayerGameState extends State<BricklayerGame> {
  late FocusNode _focusNode;
  int remainingBricks = 4;
  //focus node operation
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  // BALL VARIABLE
  double ballX = 0; //position of ball on the x axis
  double ballY = 0; //position of y on the y
  double ballXMovement = 0.02;
  double ballYMovement = 0.01;
  var ballXDirection = direction.LEFT;
  var ballYDirection = direction.DOWN;

  // PLAYER SETTING
  double playerX = -0.2; // horizontal gaps on the x axis when moving
  double playerWidth = 0.4; //width of brick

  //game setting
  bool hasGameStarted = false;
  bool isGameOver = false;

  // brick variable
  static double firstBrickX = -1 + wallGap;
  static double firstBrickY = -0.9;
  static double brickWidth = 0.4;
  static double brickHeight = 0.05;
  static double brickGap = 0.01;
  static int bricksPerRow =4;
  static double wallGap = 0.5 * ( 2 - bricksPerRow * brickWidth - (bricksPerRow - 1) * brickGap);
  bool isBrickHit = false;

  List MyBricks = [
    //row 1
    // [x, y, broken=true/false]
    [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 3 * (brickWidth + brickGap), firstBrickY, false],

    // Second row
      [
      firstBrickX + 0 * (brickWidth + brickGap),
      firstBrickY - (brickHeight + brickGap),
      false
    ],
   
  ];



  //start game
  void startGame() {
    setState(() {
      hasGameStarted = true; // Add this line
    });
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      //  Move ball
      moveBall();

      // get and update direction
      updateDirection();

      if (playerIsDead()) {
        timer.cancel();
        isGameOver = true;
      }
      //CHECKS if brick is hit
      checkBrokenBricks();
    });
  }

  // checks when ball hits bottom of brick
  void checkBrokenBricks() {
    for (int i = 0; i < MyBricks.length; i++) {
      if (ballX >= MyBricks[i][0] &&
          ballX <= MyBricks[i][0] + brickWidth &&
          ballY <= MyBricks[i][1] + brickHeight &&
          MyBricks[i][2] == false) {
        setState(() {
          MyBricks[i][2] = true;
          remainingBricks--;

          if (remainingBricks == 0) {
          isGameOver = true;
          // Display win message
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Game Over, You Win!"),
                content: Text("Congratulations, you have destroyed all the bricks!"),
                actions: [
                  ElevatedButton(
                    child: Text("Play Again"),
                    onPressed: () {
                      resetGame();
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            
            },
          );
          }


          //update direction of ball based on which side of the brick it hits

          double leftSideDist = (MyBricks[i][0] - ballX).abs();
          double rightSideDist = (MyBricks[i][0] + brickWidth - ballX).abs();
          double topSideDist = (MyBricks[i][1] - ballY).abs();
          double bottomSideDist = (MyBricks[i][1] + brickHeight - ballY).abs();


          String min = findMin(leftSideDist, rightSideDist, topSideDist, bottomSideDist);

          switch (min) {
            case 'left':
              ballXDirection = direction.LEFT;

              break;
            case 'right':
              ballXDirection = direction.RIGHT;
              break;

            case 'up':
              ballYDirection = direction.UP;
              break;

            case 'down':
              ballYDirection = direction.DOWN;
              break;
            }
          }
        );
      }
    }
  }
  //checks the smalles side and returns it
  String findMin(double a, double b, double c, double d) {
    List<double> myList = [
      a,
      b,
      c,
      d,
    ];

    double currentMin = a;
    for(int i = 0; i< myList.length; i++) {
      if (myList[i] < currentMin) {
        currentMin = myList[i];
      }
    }

    if((currentMin - a).abs() < 0.01) {
      return 'left';
    } else if((currentMin - b).abs() < 0.01) {
      return 'right';
    } else if((currentMin - c).abs() < 0.01) {
      return 'up';
    } else if((currentMin - d).abs() < 0.01) {
      return 'down';
    }
    return '';

  }

  bool playerIsDead() {
    if (ballY > 1) {
      return true;
    }
    return false;
  }

  // void moveBall() {
  //   setState(() {
  //     if (ballX == direction.DOWN) {
  //       ballY += 0.01;
  //     } else if (ballX == direction.UP) {
  //       ballY -= 0.01;
  //     }
  //   });
  // }

  void moveBall() {
    setState(() {
      // move horizontally
      if (ballXDirection == direction.LEFT) {
        ballX -= ballXMovement;
      } else if (ballXDirection == direction.RIGHT) {
        ballX +=ballXMovement;
      }

      // move vertically
      if (ballYDirection == direction.DOWN) {
        ballY += ballYMovement;
      } else if (ballYDirection == direction.UP) {
        ballY -= ballYMovement;
      }
    });
  }

  void updateDirection() {
    setState(() {
      // if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
      //   ballYDirection = direction.UP;
      // } else if (ballY < -1) {
      //   ballYDirection = direction.DOWN;
      // }

      //ball goes up when it hits the bottom brick
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballYDirection = direction.UP;

      //ball goes down when it hits the top
      } else if (ballY <= -1) {
        ballYDirection = direction.DOWN;
      }

      
      
      //ball goes left when it hits the right walls
      if (ballX >= 1) {
        ballXDirection = direction.LEFT;

      // ball goes right when it hits the left walls
      } else if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
      
      
      
    });
  }

  void moveLeft() {
    if (hasGameStarted && !isGameOver) {
      // Logic that moves left only when it is not off the screen
      if ((playerX - 0.2 >= -1)) {
        playerX -= 0.2;
      }
    }
  }

  void moveRight() {
    if (hasGameStarted && !isGameOver) {
      // Logic that moves right only when it is not off the screen
      if (!(playerX + playerWidth >= 1)) {
        playerX += 0.2;
      }
    }
  }

  void resetGame(){
    setState(() {
      playerWidth = 0.2;
      ballX = 0;
      ballY = 0;
      isGameOver = false;
      hasGameStarted = false;
      MyBricks = [

        [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
        [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
        [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false],
        [firstBrickX + 3 * (brickWidth + brickGap), firstBrickY, false],

        [
          firstBrickX + 0 * (brickWidth + brickGap),
          firstBrickY - (brickHeight + brickGap),
          false
        ],
    
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardListener(
        focusNode: _focusNode,

        // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
        onKeyEvent: (KeyEvent) {
          if (KeyEvent is KeyDownEvent) {
            if (KeyEvent.logicalKey == LogicalKeyboardKey.arrowLeft) {
              moveLeft();
            } else if (KeyEvent.logicalKey == LogicalKeyboardKey.arrowRight) {
              moveRight();
            }
          }
        },
        child: GestureDetector(
          onTap: startGame,
          child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 104, 162, 209),
            body: Center(
              child: Stack(
                children: [
                  BrickCover(hasGameStarted: hasGameStarted),

                  // Game over
                  GameOver(
                    isGameOver: isGameOver,
                    resetGame: resetGame,
                    ),

                  // BALL
                  TheBall(
                    ballX: ballX,
                    ballY: ballY,
                  ),

                  // Player
                  ThePlayer(
                    playerX: playerX,
                    playerWidth: playerWidth,
                  ),

                  //BRICKs
                  TheBrick(
                    brickHeight: brickHeight,
                    brickWidth: brickWidth,
                    brickX: MyBricks[0][0],
                    brickY: MyBricks[0][1],
                    isBrickHit: MyBricks[0][2],
                  ),
                  TheBrick(
                    brickHeight: brickHeight,
                    brickWidth: brickWidth,
                    brickX: MyBricks[1][0],
                    brickY: MyBricks[1][1],
                    isBrickHit: MyBricks[1][2],
                  ), 
                  TheBrick(
                    brickHeight: brickHeight,
                    brickWidth: brickWidth,
                    brickX: MyBricks[2][0],
                    brickY: MyBricks[2][1],
                    isBrickHit: MyBricks[2][2],
                  ),
                  TheBrick(
                    brickHeight: brickHeight,
                    brickWidth: brickWidth,
                    brickX: MyBricks[3][0],
                    brickY: MyBricks[3][1],
                    isBrickHit: MyBricks[3][2],
                  ),
                  TheBrick(
                    brickHeight: brickHeight,
                    brickWidth: brickWidth,
                    brickX: MyBricks[0][0],
                    brickY: MyBricks[0][1],
                    isBrickHit: MyBricks[0][2],
                  ),
                  // TheBrick(
                  //   brickHeight: brickHeight,
                  //   brickWidth: brickWidth,
                  //   brickX: MyBricks[4][0],
                  //   brickY: MyBricks[4][1],
                  //   isBrickHit: MyBricks[4][2],
                  // ),

                  // Container(
                  //   alignment: Alignment(playerX, 0.9),
                  //   child: Container(
                  //     color: Colors.red,
                  //     width: 4,height: 30,
                  //   ),
                  // ),
                  // Container(
                  //   alignment: Alignment((playerX+playerWidth), 0.9),
                  //   child: Container(
                  //     color: Colors.green,
                  //     width: 4,height: 30,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
