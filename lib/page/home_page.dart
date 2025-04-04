import 'package:flutter/material.dart';
import 'package:picture_charade3/core/core/app_routes.dart';
import 'package:picture_charade3/model/picture_charade.dart';
import 'package:picture_charade3/page/game_page.dart';

import '../core/widgets/card_button.dart';

const backroundImage = 'assets/images/images_card/backround.png';

class HomePage extends StatefulWidget {
  final List<PictureCharade> items;

  const HomePage({super.key, required this.items});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Picture Charade")),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(backroundImage, fit: BoxFit.cover),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Current Level: ${widget.items.first.level}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Button(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GamePage(items: widget.items),
                      ),
                    );
                  },
                  widget: Icon(Icons.games, color: Colors.white),
                ),

                const SizedBox(height: 10),
                Button(
                  onPressed: () {},
                  widget: Icon(Icons.home, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
