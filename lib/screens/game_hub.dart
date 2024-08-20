// game_hub_screen.dart
import 'package:flutter/material.dart';
import 'package:treasureguess/screens/bricklayer/bricklayer.dart';
import 'package:treasureguess/screens/snakegame.dart';
import 'package:treasureguess/screens/tetris/game_board.dart';
import 'package:treasureguess/screens/treasure_game.dart';

class Game {
  final String name;
  final String imageurl;
  Game({required this.name, required this.imageurl});
}


class GameListScreen extends StatelessWidget {
  GameListScreen({super.key});
 
  final List<Game> games = [
    Game(
      name: 'Treasure Hunt',
      imageurl: 'images/img.png',
    ),
    Game(
      name: 'Brick Layer',
      imageurl: 'images/brickimg.png',
    ),
    Game(
      name: 'Snake',
      imageurl: 'images/image.png',
    ),
    Game(
      name: 'Tetris',
      imageurl: 'images/tetris.png',
    ),
    
  
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Hub'),
      ),
      
      body: GridView.builder(
       
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: games.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const TreasureGame(title: 'Treasure Game')),
                );
              } else if (index == 1) {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const BricklayerGame()),
                );
              } else if (index == 2) {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const SnakeGame(title: 'Snake Game')),
                );
              }  else if (index == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                           WeatherApp()),
                );
              }
             
            },
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: ClipRRect(
                        // ignore: prefer_const_constructors
                        borderRadius: BorderRadius.vertical(
                          top:const Radius.circular(15.0)
                          ),
                          child: Image.asset(
                          games[index].imageurl,
                          fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          games[index].name,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        
                        ),
                      ),
                  ]
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
        
                  
                
                
                  
                        
    
                        
// class GameHubScreen extends StatelessWidget {
//   const GameHubScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Game Hub'),
//       ),
//       body: GridView.count(
//         crossAxisCount: 2, // 2 columns
//         children: [
//           GameCard(
            
//             onPressed: () {
//               // Navigate to Game 1 screen
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const TreasureGame(title: 'Treasure game')),
//               );
//             },
            
//             child: Padding(
              
//               padding: const EdgeInsets.all(20), // Add padding around the Gamecard
//               child: Expanded(
//                 flex: 1,
//                 child: Column(
//                   children: [
//                     Image.asset('images/img.png',
//                         height: 50, width: 30),
//                     const SizedBox(
//                         height:
//                             10), // Add some space between the image and the text
//                     const Text(
//                       'Game 2 Title',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(
//                         height:
//                             5), // Add some space between the title and the description
//                     const Text(
//                       'Game 2 Description',
//                       style: TextStyle(fontSize: 14),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           // Add more games here
//         ],
//       ),
//     );
//   }
// }

// class GameCard extends StatelessWidget {

//   final VoidCallback onPressed;
//   final Widget child;
  

//   const GameCard(
//       {super.key, 
      
//       required this.onPressed, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
      
//         width: 10,
//         height: 10,
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 2,
//                 blurRadius: 7,
//                 offset: const Offset(0, 3), // changes position of shadow
//               ),
//             ],
//         ),
//         child: Card(
//           child: InkWell(
//             onTap: onPressed,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
                
//                 children: [
//                   child,
                 
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
    
//   }
// }
          
   
//  GameCard(
//             gameName: 'Treasure Guess Game',
//             gameDescription: 'A fun platformer',
//             onPressed: () {
//               // Navigate to Game 1 screen
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const TreasureGame(title: 'Treasure game')),
//               );
//             },
//           ),