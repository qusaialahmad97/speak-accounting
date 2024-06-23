import 'package:flutter/material.dart';

class QuizResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final int streak;

  const QuizResultPage({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score: $score / $totalQuestions',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (streak > 0)
              Text(
                'Great Streak! You answered $streak questions in a row!',
                style: const TextStyle(fontSize: 18),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to Quizzes'),
            ),
          ],
        ),
      ),
    );
  }
}