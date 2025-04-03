import 'package:flutter/material.dart';
import 'package:picture_charade3/model/picture_charade.dart';
import 'package:picture_charade3/page/game_page.dart';

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
      appBar: AppBar(
        title: const Text("Picture Charade"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Current Level: 1"),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GamePage(items: widget.items),
                    ),
                  );
                },
                child: Text("Play current level")),
            SizedBox(height: 10),
            ElevatedButton(onPressed: () {}, child: Text("Play first level")),
          ],
        ),
      ),
    );
  }
}
