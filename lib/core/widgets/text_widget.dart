import 'package:flutter/material.dart';

import '../theme/colors.dart';

class TextWidgetLevel extends StatelessWidget {
  final int level;
  const TextWidgetLevel({
    required this.level,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "LEVEL\n    $level",
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}

class TextWidgetCoin extends StatelessWidget {
  final int coins;
  const TextWidgetCoin({
    super.key, required this.coins,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "$coins",
      style: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
