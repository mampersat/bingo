import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:bingo/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';

class PlayScreen extends StatefulWidget {
  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  List<String> board;
  List<bool> selected = new List.filled(25, false);
  bool alerted = false;
  final player = AudioCache();

  @override
  void initState() {
    super.initState();
    setup();
  }

  void setup() {
    board = [...words];
    board.shuffle();
    board[12] = "Free Space\n\nLove You";
    selected = new List.filled(25, false);
    selected[12] = true;
    alerted = false;
  }

  bool isBingo() {
    List<bool> s = selected;

    // Check Rows
    if (s[0] && s[1] && s[2] && s[3] && s[4]) return true;
    if (s[5] && s[6] && s[7] && s[8] && s[9]) return true;
    if (s[10] && s[11] && s[12] && s[13] && s[14]) return true;
    if (s[15] && s[16] && s[17] && s[18] && s[19]) return true;
    if (s[20] && s[21] && s[22] && s[23] && s[24]) return true;

    // Check Columns
    if (s[0] && s[5] && s[10] && s[15] && s[20]) return true;
    if (s[1] && s[6] && s[11] && s[16] && s[21]) return true;
    if (s[2] && s[7] && s[12] && s[17] && s[22]) return true;
    if (s[3] && s[8] && s[13] && s[18] && s[23]) return true;
    if (s[4] && s[9] && s[14] && s[19] && s[24]) return true;

    // Check diagnols
    if (s[0] && s[6] && s[12] && s[18] && s[24]) return true;
    if (s[4] && s[8] && s[12] && s[16] && s[20]) return true;

    return false;
  }

  void checkSpecial(int i) {
    print(board[i]);
    if (board[i] == 'RPM Fanfare') player.play('rpm-fanfare.mp3');
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
          )
        ],
        context: context,
        title: 'Bingo',
      ).show();
      alerted = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bingo'),
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
          FlatButton(
            child: Icon(Icons.autorenew),
            onPressed: () {
              setState(() {
                setup();
              });
            },
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
            color: selected ? Colors.blueGrey : Colors.white10,
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
