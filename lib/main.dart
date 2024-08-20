import 'package:flutter/material.dart';
import 'package:treasureguess/screens/game_hub.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Treasure Guess',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  GameListScreen(),
    );
  }
}

