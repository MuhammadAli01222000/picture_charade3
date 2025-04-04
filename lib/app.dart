import 'package:flutter/material.dart';
import 'package:picture_charade3/page/home_page.dart';
import 'package:picture_charade3/page/splash_page.dart';


class PictureCharadeApp extends StatelessWidget {
  const PictureCharadeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
