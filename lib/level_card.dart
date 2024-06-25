import 'package:flutter/material.dart';
import 'package:speak_accounting/level.dart';
import 'package:speak_accounting/level_details_page.dart';

class LevelCard extends StatelessWidget {
  final Level level;
  final Function updateProgress;
  final Map<String, dynamic>? progress;

  const LevelCard({
    super.key,
    required this.level,
    required this.updateProgress,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LevelDetailsPage(
                level: level,
                updateProgress: updateProgress,
                progress: progress,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                level.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Add progress bar here for the entire level
              LinearProgressIndicator(
                value: level.getAverageProgress(progress),
                // Calculate average progress for the level
                minHeight: 10,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation(Colors.deepPurpleAccent),
              ),
              const SizedBox(height: 10),
              if (level.lessons.every((lesson) =>
                  lesson.sections.any((section) =>
                  progress?[lesson.title]?[section.title] == 1.0)))
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 24,
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}