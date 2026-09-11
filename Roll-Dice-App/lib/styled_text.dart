import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String textInput;

  const StyledText({super.key, required this.textInput});

  @override
  Widget build(context) {
    return Text(style: TextStyle(fontSize: 28, color: Colors.white), textInput);
  }
}
