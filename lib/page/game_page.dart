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

const coin = 'assets/images/img.png';

class GamePage extends StatefulWidget {
  final List<PictureCharade> items;
  const GamePage({super.key, required this.items});

  @override
  State<GamePage> createState() => _GamePageState();
}

int index = 0;
bool sound=false;
class _GamePageState extends State<GamePage> {

  List<String?> placedLetters = [];
  bool description = false;
  final _player = AudioPlayer();
  int coins = 0;

  void pause() {
    setState(() {});
    if (sound) {
      _player.pause();
      sound = false;
    } else {
      _player.play();
      sound = true;
    }
  }

  @override
  void initState() {
    super.initState();
    play();
    placedLetters = List.filled(widget.items[index].word.length, null);
  }

  Future<void> play() async {
    try {
      await _player.setAsset('assets/sound/game_sound.mp3');
      await _player.play();
    } catch (s) {
      debugPrint("error $s");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _checkAnswer() {
    String userAnswer = placedLetters.join();
    String correctAnswer = widget.items[index].word;

    if (userAnswer == correctAnswer) {
      //coins+=100;
      coins += widget.items[index].coin;
      CustomDialog.dialogCorrect(
        context,
        widget.items[index].imageUrl,
        widget.items[index].word,
      );

      setState(() {
        if (index < widget.items.length - 1) {
          index++;
          placedLetters = List.filled(widget.items[index].word.length, null);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tabriklayman yutdingiz.')),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Noto‘g‘ri javob')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int level = widget.items[index].level;
    int leftColor = 0xFF000000 | widget.items[index].left.color;
    int rightColor = 0xFF000000 | widget.items[index].right.color;

    return WillPopScope(
      onWillPop: () async {
        pause();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(coins: coins, level: level),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _lightButton(),
                  soundButton(),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: _buildImageCard(widget.items[index].left.imageUrl, leftColor, widget.items[index].left.fill),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    flex: 1,
                    child: _buildImageCard(widget.items[index].right.imageUrl, rightColor, widget.items[index].right.fill),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (description)
                Card(
                  color: CupertinoColors.activeBlue,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      widget.items[index].description,
                      style:  TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              _buildDropTarget(leftColor, rightColor),
              const SizedBox(height: 16),
              _buildDraggableLetters(),
              const SizedBox(height: 100),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _checkAnswer,
                icon: const Icon(Icons.check, color: Colors.white),
                label: const Text("See the result ", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard(String imageUrl, int color, int fill) {
    return SizedBox(
      height: 320,
      child: Card(
        color: AppColors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Container(

          width: double.infinity,
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox( height : 270,child: Image.asset(imageUrl, height: 120, fit: BoxFit.contain)),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: fill / 10,
                color: Color(color),
                backgroundColor: Colors.grey.shade300,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropTarget(int leftColor, int rightColor) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade300),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        children: List.generate(widget.items[index].word.length, (i) {
          final isMiddle = i == widget.items[index].middleLetter;
          return DragTarget<String>(
            onAccept: (letter) => setState(() => placedLetters[i] = letter),
            builder: (context, candidateData, rejectedData) {
              return Container(
                width: 50,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isMiddle
                        ? [Color(leftColor), Color(rightColor)]
                        : [Colors.blue, Colors.blueAccent],
                  ),
                ),
                child: Text(
                  placedLetters[i] ?? '',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildDraggableLetters() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: widget.items[index].letters.map((letter) {
        return Draggable<String>(
          data: letter,
          feedback: Material(
            color: Colors.transparent,
            child: _letterBox(letter, drag: true),
          ),
          childWhenDragging: Opacity(
            opacity: 0.3,
            child: _letterBox(letter),
          ),
          child: _letterBox(letter),
        );
      }).toList(),
    );
  }

  Widget _letterBox(String letter, {bool drag = false}) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: drag ? Colors.blueAccent : CupertinoColors.activeBlue,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          if (drag)
            const BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            )
        ],
      ),
      child: Center(
        child: Text(
          letter,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget soundButton() {
    return IconButton(
      onPressed: pause,
      icon:  Icon(sound? Icons.volume_down: Icons.volume_off, color: Colors.redAccent),
    );
  }

  Widget _lightButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          description = !description;
          coins = coins - 100;
        });
      },
      icon: const Icon(Icons.lightbulb, color: Colors.green),
    );
  }

  AppBar _buildAppBar({required int coins, required int level}) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      title: Row(
        children: [
          TextWidgetLevel(level: level),
          const Spacer(),
          Row(
            children: [
              Image.asset(coin, height: 24),
              const SizedBox(width: 8),
              TextWidgetCoin(coins: coins),
            ],
          ),
        ],
      ),
    );
  }
}
