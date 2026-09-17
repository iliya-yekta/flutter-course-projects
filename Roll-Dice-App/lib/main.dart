import 'package:flutter/material.dart';

import 'package:roll_dice_app/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer([
          Color.fromARGB(255, 55, 2, 129),
          Color.fromARGB(255, 75, 16, 202),
        ]),
      ),
    ),
  );
}
