import 'package:flutter/material.dart';
import 'package:speak_accounting/quiz_question.dart'; // Ensure this import is added

// QuizCard and QuizCardWidget
// QuizCard and QuizCardWidget
class QuizCard {
  final String title;
  final String? imageUrl; // Make imageUrl nullable
  final List<QuizQuestion> quizQuestions;

  QuizCard({
    required this.title,
    this.imageUrl, // Make imageUrl nullable
    required this.quizQuestions,
  });
}

class QuizCardWidget extends StatelessWidget {
  final QuizCard quizCard;
  final Function(List<QuizQuestion>) onQuizSelected;

  const QuizCardWidget({
    super.key,
    required this.quizCard,
    required this.onQuizSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          onQuizSelected(quizCard.quizQuestions);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (quizCard.imageUrl != null)
              Image.asset(
                quizCard.imageUrl!,
                height: 80,
                width: 80,
              ),
            const SizedBox(height: 10),
            Text(
              quizCard.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
