import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  static String id = '/about_screen';

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Text(
            '''
What: This is a bingo game to play during Josh Kantors 7th Inning Stretch internet show on facbook. The words in the squares are things that happen most every show and the sounds on some squares come straight from the show.

Prizes: Internet Chat Points (aka No Prizes)

Rules: None, but should probably limit it to things seen and heard vs. things in the chat.

Why: During the pandemic I'm trying to learn how to develop web and mobile apps using a technology called Flutter. This was a fun personal project - some call them passion projects. I've always been a fan of Dilbert's Buzz Word Bingo but never 100% happy with the many implementations of it - SO - I decided to make another one. I build software as part of larger teams most of the time and it's really fun to be a one-person-show sometimes. I've learned a lot building this. 

Dedications:
Reverend Producer Mary
Josh Kantor
''',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
