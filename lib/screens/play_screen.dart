import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:bingo/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';

class PlayScreen extends StatefulWidget {
  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  List<bool> selected = new List.filled(25, false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    words.shuffle();
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
                      selected: selected[x * 5 + y],
                      onPressed: () {
                        setState(() {
                          selected[x * 5 + y] = !selected[x * 5 + y];
                        });
                      },
                    ),
                ],
              ),
            )
        ],
      ),
    );
  }
}

class Square extends StatelessWidget {
  final int x;
  final int y;
  bool selected = false;
  Function onPressed;

  Square({this.x, this.y, this.onPressed, this.selected});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(1.0),
          child: Material(
            borderRadius: BorderRadius.circular(10.0),
            color: selected ? Colors.blueGrey : Colors.white10,
            child: Center(
              child: Text(
                words[x * 5 + y],
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
