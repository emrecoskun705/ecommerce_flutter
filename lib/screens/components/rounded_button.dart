import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color primaryColor;
  final Color bgColor;
  final String title;
  final VoidCallback onPressed;

  RoundedButton(
      {required this.primaryColor,
      required this.title,
      required this.onPressed,
      required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: this.bgColor,
        primary: this.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
      onPressed: this.onPressed,
      child: Text(this.title),
    );
    ;
  }
}
