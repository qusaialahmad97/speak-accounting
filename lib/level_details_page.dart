import 'package:flutter/material.dart';
import '/level.dart';
import '/lesson_card.dart'; // Import LessonCard if needed
// Import LessonSectionCard

class LevelDetailsPage extends StatefulWidget {
  final Level level;
  final Function updateProgress;
  final Map<String, dynamic>? progress;

  const LevelDetailsPage({
    super.key,
    required this.level,
    required this.updateProgress,
    this.progress,
  });

  @override
  _LevelDetailsPageState createState() => _LevelDetailsPageState();
}

class _LevelDetailsPageState extends State<LevelDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text(
          widget.level.title,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding for the content
        child: ListView.builder(
          itemCount: widget.level.lessons.length,
          itemBuilder: (context, index) {
            final lesson = widget.level.lessons[index];
            return LessonCard(
              lesson: lesson,
              updateProgress: widget.updateProgress,
              progress: widget.progress?[lesson.title],
            );
          },
        ),
      ),
    );
  }
}