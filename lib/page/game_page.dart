import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picture_charade3/core/widgets/dialog.dart';
import 'package:picture_charade3/model/picture_charade.dart';
import 'package:just_audio/just_audio.dart';
import '../core/theme/colors.dart';
import '../core/theme/icons.dart';
import '../core/widgets/card_button.dart';
import '../core/widgets/icon_button.dart';
import '../core/widgets/text_widget.dart';

/// coin img url
const coin = 'assets/images/img.png';

class GamePage extends StatefulWidget {
  final List<PictureCharade> items;
  const GamePage({super.key, required this.items});

  @override
  State<GamePage> createState() => _GamePageState();
}

int index = 0;

class _GamePageState extends State<GamePage> {
  /// resultni yegish  uchun list
  List<String?> placedLetters = [];
  bool description = false;
  final _player = AudioPlayer();
///pause
  void pause() {
    _player.pause();
  }
  @override
  void initState() {
    super.initState();
    play();
    placedLetters = List.filled(widget.items[index].word.length, null);
  }
  ///sound
Future<void> play() async{
    try{
     await _player.setAsset('assets/sound/game_sound.mp3');
     await _player.play();

    }catch(s){
      debugPrint("error $s");
    }
}


  ///logic check answer
  void _checkAnswer() {
    String userAnswer = placedLetters.join();
    String correctAnswer = widget.items[index].word;

    if (userAnswer == correctAnswer) {
      coins += widget.items[index].coin;
      CustomDialog.dialogCorrect(
        context,
        widget.items[index].imageUrl,
        widget.items[index].word,
      );

      setState(() {
        if (index < widget.items.length - 1) {
          index++; //keyngi savolga
          placedLetters = List.filled(widget.items[index].word.length, null);
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Tabriklayman yutdingiz.')));
        }
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Noto‘g‘ri javob')));
    }
  }

  ///coin olish
  int coins = 0;
  @override
  Widget build(BuildContext context) {
    /// level olish uchun
    int level = widget.items[index].level;

    ///rang olish uchun
    int leftColor = 0xFF000000 | widget.items[index].left.color;
    int rightColor = 0xFF000000 | widget.items[index].right.color;

    /// description ochish uchn
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Button(onPressed: _checkAnswer, widget:Text( '')),
      ),
      appBar: _buildAppBar(coins: coins, level: level),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _light_button(),
 const          SizedBox(height: 10,),
            soundOf(),
            Center(
              child: Row(
                children: [
                  Spacer(),

                  /// Left image
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
                            height: 100,
                          ),
                          Container(
                            height: 25,
                            width: 100,
                            color: Color(leftColor),
                            child: Center(
                              child: Container(
                                /// todo fill uchun
                                width: widget.items[index].left.fill * 15,
                                height: 10,
                                color: Colors.white,
                                child: Row(
                                  /// todo img tagidagi sozlar sonini bildiruvchi circle lar
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (
                                      var i = 0;
                                      i < widget.items[index].left.fill;
                                      i++
                                    )
                                      Expanded(
                                        child: Container(
                                          width: 8,
                                          height: 8,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(leftColor),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),

                  /// Right image
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
                            height: 100,
                          ),
                          Container(
                            height: 25,
                            width: 100,
                            color: Color(rightColor),
                            child: Center(
                              child: Container(
                                width: 50,
                                height: 10,
                                color: Colors.white,
                                child: Row(
                                  /// todo img tagidagi sozlar sonini bildiruvchi circle lar
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (
                                      var i = 0;
                                      i < widget.items[index].right.fill;
                                      i++
                                    )
                                      Expanded(
                                        child: Container(
                                          width: 8,
                                          height: 8,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(rightColor),
                                          ),
                                        ),
                                      ),
                                  ],
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
            description
                ? SizedBox(
                  width: 250,
                  height: 40,
                  child: Card(
                    color: CupertinoColors.activeBlue,
                    child: Center(
                      child: Text(
                        widget.items[index].description,
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
                : Text(''),

            /// Drop target todo [ colorni ozgartir]
            Container(
              width: 300,
              height: 75,
              color: Colors.blue.shade900,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.items[index].word.length, (i) {
                    return Expanded(
                      child: DragTarget<String>(
                        onAccept: (letter) {
                          setState(() {
                            placedLetters[i] = letter;
                          });
                        },
                        builder: (context, candidateData, rejectedData) {
                          return Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient:
                                  (i == widget.items[index].middleLetter)
                                      ? LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(
                                            leftColor,
                                          ),
                                          Color(
                                            rightColor,
                                          ),
                                        ],
                                      )
                                      : LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors
                                              .blue,
                                          Colors.blue,
                                        ],
                                      ),
                              border: Border.all(color: Colors.grey, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                placedLetters[i] ?? "",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ),
              ),
            ),
            Spacer(),

            /// Draggable letters
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.items[index].letters.length, (i) {
                return Expanded(
                  child: Draggable<String>(
                    data: widget.items[index].letters[i],
                    feedback: Material(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            widget.items[index].letters[i],
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: CupertinoColors.activeBlue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          widget.items[index].letters[i],
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 45),
          ],
        ),
      ),
    );
  }

  ///icon button sound of
  Align soundOf() {
    return Align(
      alignment: Alignment(0.8, 0.8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.redAccent,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () => pause(),
          icon: Icon(Icons.volume_off, color: Colors.yellowAccent),
        ),
      ),
    );
  }

  ///appbar
  AppBar _buildAppBar({required int coins, required int level}) {
    return AppBar(
      backgroundColor: Colors.white70,
      elevation: 0,
      title: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: TextWidgetLevel(level: level),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 120,
                    height: 45,
                    child: Card(
                      color: AppColors.grey,

                      child: Row(
                        children: [
                          SizedBox(width: 9),

                          SizedBox(
                            height: 35,
                            child: Image.asset(coin, fit: BoxFit.contain),
                          ),
                          SizedBox(width: 15),
                          TextWidgetCoin(coins: coins),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      actions: [
        SizedBox(width: 15),

        AppIconButton(
          colorIcon: AppColors.black,
          colorBackround: AppColors.black,
          icon: AppIcons.menu,
          function: () {},
          radius: 2,
        ),
      ],
    );
  }

  ///o'ng tarafdagi yashil button
  Align _light_button() {
    return Align(
      alignment: Alignment(0.8, -0.9),
      child: SizedBox(
        width: 50,
        height: 50,
        child: Stack(
          children: [
            Card(
              color: Colors.green,
              child: Center(
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      description = !description;
                      coins - 100;

                      /// -= 100;          todo result coin
                    });
                  },
                  icon: Icon(Icons.lightbulb, color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
