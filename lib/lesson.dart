import 'package:speak_accounting/lesson_section.dart';

class Lesson {
  final String title;
  final List<LessonSection> sections;
  Map<String, dynamic>? progress; // Add this line

  Lesson({
    required this.title,
    required this.sections,
    this.progress, // Add this line
  });

  // Calculate the average progress for the entire lesson
  double getAverageProgress(Map<String, dynamic>? progress) {
    if (sections.isEmpty) return 0.0;
    return sections.fold<double>(0.0, (sum, section) {
      final sectionProgress = progress?[section.title] ?? 0.0; // Read from nested progress
      return sum + sectionProgress;
    }) / sections.length;
  }

  int getCompletedSectionCount(Map<String, dynamic>? progress) {
    return sections.where((section) => progress?[section.title] == 1.0).length; // Read from nested progress
  }
}