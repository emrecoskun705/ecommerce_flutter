import 'package:flutter/cupertino.dart';

class AccountChoice {
  final String name;
  final IconData icon;
  final VoidCallback function;

  AccountChoice(
      {required this.name, required this.icon, required this.function});
}
