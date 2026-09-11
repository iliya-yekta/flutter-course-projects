import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionNumber extends StatelessWidget {
  const QuestionNumber({
    super.key,
    required this.questionIndex,
    required this.isCorrectAnswer,
  });

  final int questionIndex;
  final bool isCorrectAnswer;

  @override
  Widget build(context) {
    final Color bgColorIcon = !isCorrectAnswer ? Colors.pink : Colors.lightBlue;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(color: bgColorIcon, shape: BoxShape.circle),
      child: Text(
        ((questionIndex) + 1).toString(),
        style: GoogleFonts.lato(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
