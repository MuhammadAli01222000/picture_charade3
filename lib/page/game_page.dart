import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picture_charade3/model/picture_charade.dart';

class GamePage extends StatefulWidget {
  final List<PictureCharade> items;
  const GamePage({super.key, required this.items});

  @override
  State<GamePage> createState() => _GamePageState();
}

int index = 0;

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    int leftColor = 0xFF000000 | widget.items[index].left.color;
    int rightColor = 0xFF000000 | widget.items[index].right.color;

    print("Left Color (HEX): ${leftColor.toRadixString(16).toUpperCase()}");

    return Scaffold(
      appBar: AppBar(title: Text("${widget.items.first.level} - level")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Center(
              child: Row(
                children: [
                  Spacer(),

                  ///todo left img
                  SizedBox(
                    width: 100,
                    height: 140,
                    child: Card(
                      child: Column(
                        children: [
                          Image.asset(
                            widget.items[index].left.imageUrl,
                            fit: BoxFit.contain,
                            width: 100,
                            height: 110,
                          ),
                          Container(
                            height: 22,
                            width: 100,
                            child: Card(
                              color: Color(leftColor),
                              child: Center(
                                child: Container(
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      for (
                                        var i = 0;
                                        i < widget.items[index].left.fill;
                                        i++
                                      )
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(leftColor),
                                          ),
                                        ),
                                      SizedBox(width: 3),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),

                  ///todo right img
                  SizedBox(
                    width: 100,
                    height: 140,
                    child: Card(
                      child: Column(
                        children: [
                          Image.asset(
                            widget.items[index].right.imageUrl,
                            fit: BoxFit.contain,
                            width: 100,
                            height: 110,
                          ),
                          Container(
                            height: 22,
                            width: 100,
                            child: Card(
                              color: Color(rightColor),
                              child: Center(
                                child: Container(
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      for (
                                        var i = 0;
                                        i < widget.items[index].right.fill;
                                        i++
                                      )
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(rightColor),
                                          ),
                                        ),
                                      SizedBox(width: 3),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: 300,
              height: 75,
              color: Colors.blue.shade900,
              child: Center(
                child: Row(
                  children: [
                    for (var i = 0; i < widget.items[index].word.length; i++)
                      Expanded(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Color(leftColor),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment(0, 0),
              child: Row(
                children: [
                  Spacer(),
                  for (var i = 0; i < widget.items[index].letters.length; i++)
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: Card(
                        color: CupertinoColors.activeBlue,
                        child: Center(
                          child: Text(widget.items[index].letters[i]),
                        ),
                      ),
                    ),
                  Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
