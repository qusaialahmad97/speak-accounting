import 'package:speak_accounting/lesson.dart';

class Level {
  final String title;
  final List<Lesson> lessons;

  Level({
    required this.title,
    required this.lessons,
  });

  // Calculate the average progress across all lessons in the level
  double getAverageProgress(Map<String, dynamic>? progress) {
    if (lessons.isEmpty) return 0.0; // Handle empty level case

    double totalProgress = 0.0;
    for (var lesson in lessons) {
      totalProgress += lesson.getAverageProgress(progress?[lesson.title] as Map<String, dynamic>?);
    }
    return totalProgress / lessons.length;
  }
}