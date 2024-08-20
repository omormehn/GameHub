import 'dart:math';

import 'package:flutter/material.dart';

class TreasureGame extends StatefulWidget {
  const TreasureGame({super.key, required this.title});

  final String title;

  @override
  State<TreasureGame> createState() => _TreasureGameState();
}

class _TreasureGameState extends State<TreasureGame> {
  int _treasure = 0;
  int _guessCount = 0;
  int _score = 0;
  Random random = new Random();
  String _hint = '';

  void _generateNewTreasure() {
    setState(() {
      _treasure = random.nextInt(9);
      _guessCount = 0;
      _hint = '';
    });
  }

  void _displayTreasure() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('WINNER'),
          content: Card(
            child: Image.asset('images/treasure.png'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _generateNewTreasure();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/img.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                height: 100,
                width: 300,
                padding: const EdgeInsets.all(15.0),
                decoration: const BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Please Click on any of the boxes below to unearth your treasure',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              _hint,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
                ),
              ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  padding: const EdgeInsets.all(20),
                  children: List.generate(9, (index) {
                    return ElevatedButton(
                      onPressed: () {
                        if (_guessCount < 5) {
                          if (index == _treasure) {
                            setState(() {
                              _score++;
                              _guessCount = 0;
                            });
                            _displayTreasure();
                            _generateNewTreasure();
                          } else {
                            setState(() {
                              _guessCount++;
                              if (_guessCount == 1) {
                                _hint = 'Try again!';
                              } else if (_guessCount == 2) {
                                _hint = 'You are getting close!';
                              } else if (_guessCount == 3) {
                                _hint = 'Almost there!';
                              } else if (_guessCount == 4) {
                                _hint = 'Last chance!';
                              } else if (_guessCount == 5) {
                                _hint = 'Chances Exhausted, Try again';
                              }
                            });
                            _showWrongGuessDialog();
                          }
                        } else {
                          _showExhaustedGuessDialog();
                        }
                      },
                      style: const ButtonStyle(),
                      child: Image.asset('images/guess3.png'),
                    );
                  }),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Card(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _score = 0;
                          _generateNewTreasure();
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.restart_alt,
                              size: 40,
                            ),
                            Text(
                              'Restart',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.numbers,
                            size: 40,
                          ),
                          Text(
                            'Score: $_score',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }

  void _showWrongGuessDialog() {
    showDialog(
      context: context,
            builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Wrong Guess'),
          content: const Text('Try again!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showExhaustedGuessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exhausted Guesses'),
          content: const Text('You have exhausted your 5 guesses. Try again!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _generateNewTreasure();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
       



// import 'dart:math';

// import 'package:flutter/material.dart';


// class TreasureGame extends StatefulWidget {
//   const TreasureGame({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<TreasureGame> createState() => _TreasureGameState();
// }

// class _TreasureGameState extends State<TreasureGame> {
//   int _treasure = 0;
//   int _guessCount = 0;
//   int _score = 0;
//   Random random = new Random();

//   void _generateNewTreasure() {
//     setState(() {
//       _treasure = random.nextInt(9);
//       _guessCount = 0;
//     });
//   }

//   void _displayTreasure() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('WINNER'),
//           content: Card(
//             child: Image.asset('images/treasure.png'),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _generateNewTreasure();
//     // WidgetsBinding.instance.addPostFrameCallback((_) => switcher());
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: DecoratedBox(
//         // BoxDecoration takes the image
//         decoration: BoxDecoration(
//           // Image set to background of the body
//           image: DecorationImage(
//               image: AssetImage("images/img.png"), fit: BoxFit.cover),
//         ),
//         child: Center(
//             child: Column(children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(top: 30.0),
//             child: Container(
//               height: 100,
//               width: 300,
//               padding: const EdgeInsets.all(15.0),
//               decoration: BoxDecoration(
//                 color: Colors.brown,
//                 borderRadius: BorderRadius.all(Radius.circular(25)),
//               ),
//               alignment: Alignment.center,
//               child: const Text(
//                 'Please Click on any of the boxes below to unearth your treasure',
//                 style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           Expanded(
//             child: Container(
//               alignment: Alignment.center,
//               child: GridView.count(
//                 crossAxisCount: 3,
//                 mainAxisSpacing: 20.0,
//                 crossAxisSpacing: 20.0,
//                 padding: const EdgeInsets.all(20),
//                 children: List.generate(9, (index) {
//                   return ElevatedButton(
//                     onPressed: () {
//                       if (_guessCount < 3) {
//                         if (index == _treasure) {
//                           setState(() {
//                             _score++;
//                           });
//                           _score;
//                           _displayTreasure();
//                           _generateNewTreasure();
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                             content: Text("Wrong Guess"),
//                             duration: Duration(seconds: 2, milliseconds: 200),
//                             backgroundColor: Colors.red,
//                           ));
//                           _guessCount++;
//                         }
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                           content: Text("You have exausted your guess"),
//                           duration: Duration(seconds: 2, milliseconds: 200),
//                           backgroundColor: Colors.red,
//                         ));
//                       }
//                     },
//                     style: ButtonStyle(),
//                     child: Image.asset('images/guess3.png'),
//                   );
//                 }),
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Expanded(
//                 child: Card(
//                   child: InkWell(
//                     onTap: () {},
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Column(
//                         children: [
//                           Icon(
//                             Icons.restart_alt,
//                             size: 40,
//                           ),
//                           Text(
//                             'Restart',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Card(
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       children: [
//                         Icon(
//                           Icons.numbers,
//                           size: 40,
//                         ),
//                         Text(
//                           'Score: $_score',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ])),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _generateNewTreasure,
//         tooltip: 'Replay',
//         child: const Text("Replay"),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
//