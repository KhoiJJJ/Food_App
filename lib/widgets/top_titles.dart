import 'package:flutter/material.dart';
import 'package:food_app/widgets/small_text.dart';

import 'big_text.dart';

class TopTitles extends StatelessWidget {
  final String title, subtitle;
  const TopTitles({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: kToolbarHeight,
        ),
        if (title == "Login" || title == "Create Account")
          GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: const BackButton()),
          SizedBox(height: 12,),
        BigText(
          text: title,
          size: 30,
        ),
        const SizedBox(
          height: 12,
        ),
        SmallText(
          text: subtitle,
          size: 18,
        ),
      ],
    );
  }
}
