import 'package:flutter/material.dart';
import 'package:bingo/screens/play_screen.dart';
import 'package:bingo/screens/about_screen.dart';

void main() {
  runApp(Bingo());
}

class Bingo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        //primaryColor: Color(0xFF0A0E21),
        primaryColor: Color(0xFF4A777A),
        scaffoldBackgroundColor: Color(0xFF4A777A),
      ),
      initialRoute: PlayScreen.id,
      routes: {
        PlayScreen.id: (context) => PlayScreen(),
        AboutScreen.id: (context) => AboutScreen(),
      },
    );
  }
}
