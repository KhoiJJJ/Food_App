import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;

  SmallText({super.key,
    this.color,
    required this.text,
    this.size=15,
    this.height=1.2});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size,
          height: height,
          fontWeight: FontWeight.bold,
      ),

    );
  }
}
