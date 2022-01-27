import 'package:flutter/material.dart';

class Push {
  static void to(BuildContext context, Widget page) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ));
  }
}
