// quiz_question.dart
enum QuizType { multipleChoice, trueFalse, fillInTheBlank }

class QuizQuestion {
  final QuizType type;
  final String text;
  final List<String> options;
  final String correctAnswer;
  final String? imageUrl;

  QuizQuestion({
    required this.type,
    required this.text,
    required this.options,
    required this.correctAnswer,
    this.imageUrl,
  });
}