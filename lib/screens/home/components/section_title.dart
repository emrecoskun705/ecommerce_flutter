import 'package:flutter/material.dart';

import '../../../size_config.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final VoidCallback press;

  SectionTitle({required this.text, required this.press});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: press,
            child: Text(
              'See More',
              style: TextStyle(color: Color(0xFFBBBBBB)),
            ),
          ),
        ],
      ),
    );
  }
}
