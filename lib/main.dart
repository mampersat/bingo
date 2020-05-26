import 'package:flutter/material.dart';
import 'package:bingo/screens/play_screen.dart';

void main() {
  runApp(Bingo());
}

class Bingo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        //primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: PlayScreen(), //TODO Loading page
    );
  }
}
