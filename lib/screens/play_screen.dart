import 'package:audioplayers/audio_cache.dart';
import 'package:bingo/screens/about_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:bingo/constants.dart';
// Works for mobile app
//import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
// Works on web based app
//import 'package:clippy/browser.dart' as clippy;
//import 'dart:io';
import 'package:clipboard_manager/clipboard_manager.dart';

class PlayScreen extends StatefulWidget {
  static String id = '/';
  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  List<String> board;
  List<bool> selected = new List.filled(25, false);
  String winningWords;
  bool alerted = false;
  final player = AudioCache();

  @override
  void initState() {
    super.initState();
    create_new_card();
  }

  void create_new_card() {
    //user spread operator to clone the word array
    board = [...words];
    board.shuffle();
    board[12] = "Free Space\n\nLove You";
    selected = new List.filled(25, false);
    selected[12] = true;
    alerted = false;
  }

  bool isListBingo(List<int> list) {
    bool check = true;
    String words = '';
    for (int i in list) {
      if (check &= selected[i]) {
        words += board[i].replaceAll('\n', '-') + '\n';
      }
    }

    if (check) winningWords = words;

    return check;
  }

  bool isBingo() {
    List<bool> s = selected;

    // rows
    if (isListBingo([0, 1, 2, 3, 4])) return true;
    if (isListBingo([5, 6, 7, 8, 9])) return true;
    if (isListBingo([10, 11, 12, 13, 14])) return true;
    if (isListBingo([15, 16, 17, 18, 19])) return true;
    if (isListBingo([20, 21, 22, 23, 24])) return true;

    // cols
    if (isListBingo([0, 5, 10, 15, 20])) return true;
    if (isListBingo([1, 6, 11, 16, 21])) return true;
    if (isListBingo([2, 7, 12, 17, 22])) return true;
    if (isListBingo([3, 8, 13, 18, 23])) return true;
    if (isListBingo([4, 9, 14, 19, 24])) return true;

    // diagonals
    if (isListBingo([0, 6, 12, 18, 24])) return true;
    if (isListBingo([4, 8, 12, 16, 20])) return true;

    return false;
  }

  void checkSpecial(int i) {
    // TODO refactor words to contain songs in the a real object
    if (board[i] == 'RPM Fanfare') player.play('rpm-fanfare.mp3');
    if (board[i] == 'Take me Out to the Ballgame')
      player.play('four-bar-intro.mp3');
    if (board[i] == 'Glissando') player.play('glissando.mp3');
    if (board[i] == 'Birthday') player.play('bday.mp3');
  }

  void checkBingo() {
    if (alerted) return;

    if (isBingo()) {
      Alert(
        style: AlertStyle(
          backgroundColor: Colors.white,
        ),
        buttons: [
          DialogButton(
            color: Colors.red,
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          ),
//          DialogButton(
//            color: Colors.red,
//            child: Text(
//              "Copy to Clipboard",
//              style: TextStyle(color: Colors.white, fontSize: 10),
//            ),
//            onPressed: () {
//              print(winningWords);
//              ClipboardManager.copyToClipBoard(winningWords);
//            },
//            width: 120,
//          ),
        ],
        context: context,
        title: 'Bingo',
        content: Column(
          children: <Widget>[
            SelectableText(winningWords, style: TextStyle(fontSize: 14))
          ],
        ),
      ).show();
      alerted = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
            child: Icon(Icons.menu),
            onPressed: () {
              Navigator.pushNamed(context, AboutScreen.id);
            }),
        title: Text(
          'flutt7th Inning Stretch Bingo',
        ),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.autorenew),
            onPressed: () {
              setState(() {
                create_new_card();
              });
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int x = 0; x < 5; ++x)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int y = 0; y < 5; ++y)
                    Square(
                      x: x,
                      y: y,
                      text: board[x * 5 + y],
                      selected: selected[x * 5 + y],
                      onPressed: () {
                        setState(() {
                          selected[x * 5 + y] = !selected[x * 5 + y];
                          checkBingo();
                          checkSpecial(x * 5 + y);
                        });
                      },
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class Square extends StatelessWidget {
  final int x;
  final int y;
  bool selected = false;
  final String text;
  Function onPressed;

  Square({this.x, this.y, this.text, this.onPressed, this.selected});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(1.0),
          child: Material(
            borderRadius: BorderRadius.circular(5.0),
            color: selected ? Colors.yellow : Colors.white,
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
