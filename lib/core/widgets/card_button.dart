import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Widget widget;
  final void Function() onPressed;
  const Button({super.key, required this.onPressed, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.redAccent, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),

      child: ElevatedButton(

        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: onPressed,

        child: Center(child:widget),
      ),
    );
  }
}
