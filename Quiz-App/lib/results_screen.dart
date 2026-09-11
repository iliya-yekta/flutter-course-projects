import 'package:beginner_2/data/questions.dart';
import 'package:beginner_2/question/question_summary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.selectedAnswers,
    required this.restartQuiz,
  });

  final List<String> selectedAnswers;
  final void Function() restartQuiz;

  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];

    for (int i = 0; i < selectedAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].question,
        'correct_answer': questions[i].answers[0],
        'user_answer': selectedAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData
        .where((data) => data['correct_answer'] == data['user_answer'])
        .length;

    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
            style: GoogleFonts.lato(
              fontSize: 24,
              color: const Color.fromARGB(255, 140, 81, 240),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 400,
            child: SingleChildScrollView(child: QuestionSummary(summaryData)),
          ),
          const SizedBox(height: 30),
          TextButton(
            onPressed: restartQuiz,
            style: TextButton.styleFrom(
              textStyle: GoogleFonts.lato(
                color: const Color.fromARGB(255, 86, 1, 151),
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlue, Colors.lightBlue],
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                'Restart quiz!',
                style: GoogleFonts.lato(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
