// quiz_question.dart
enum QuizType { multipleChoice, trueFalse, fillInTheBlank }

class QuizQuestion {
  final QuizType type;
  final String text;
  final List<String> options; // Changed to a List<String>
  final String correctAnswer; // Now stores the full option string
  final String? imageUrl;

  QuizQuestion({
    required this.type,
    required this.text,
    required this.options, // Changed to a List<String>
    required this.correctAnswer,
    this.imageUrl,
  });
}