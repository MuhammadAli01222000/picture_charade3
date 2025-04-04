import 'package:flutter/material.dart';

class AppIconButton extends StatefulWidget {
  final double radius;
  final Color colorIcon;
  final Color colorBackround;
  final Icon icon;
  final VoidCallback function;
  const AppIconButton({
    super.key,
    required this.colorIcon,
    required this.colorBackround,
    required this.icon,
    required this.function,
    required this.radius,
  });

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: widget.function,
        icon: widget.icon,
        color: widget.colorIcon,
        padding: EdgeInsets.all(10),
        splashRadius: widget.radius,

    );
  }
}
