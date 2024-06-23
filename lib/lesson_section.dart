import 'package:speak_accounting/quiz_question.dart';

class LessonSection {
  final String title;
  final String content;
  double progress;
  bool isExpanded = false;
  final String? imageUrl;
  final String? videoUrl;
  final List<QuizQuestion> quizQuestions;

  LessonSection({
    required this.title,
    required this.content,
    required this.progress,
    this.imageUrl,
    this.videoUrl,
    required this.quizQuestions,
  });
}