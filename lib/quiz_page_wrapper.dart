import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:speak_accounting/quiz_page.dart';
import 'package:speak_accounting/quiz_question.dart'; // Import QuizPageInternal

class QuizPageWrapper extends StatelessWidget {
  final List<QuizQuestion> quizQuestions;
  final Function(int, int) onQuizCompleted;
  final AudioPlayer correctSoundPlayer;
  final AudioPlayer incorrectSoundPlayer;

  const QuizPageWrapper({
    super.key,
    required this.quizQuestions,
    required this.onQuizCompleted,
    required this.correctSoundPlayer,
    required this.incorrectSoundPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return QuizPageInternal(
      quizQuestions: quizQuestions,
      onQuizCompleted: onQuizCompleted,
      correctSoundPlayer: correctSoundPlayer,
      incorrectSoundPlayer: incorrectSoundPlayer,
    );
  }
}