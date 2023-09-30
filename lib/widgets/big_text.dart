import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final TextOverflow overFlow;
  
  BigText({super.key, this.color ,
    required this.text,
    this.size=0,
    this.overFlow=TextOverflow.ellipsis });

  @override
  Widget build(BuildContext context) {

    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: 50,
        fontWeight: FontWeight.bold
      ),

    );
  }
}
