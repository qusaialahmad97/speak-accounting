// lesson_section_card.dart
import 'package:flutter/material.dart';
import 'package:speak_accounting/lesson_section.dart';
// Import QuizPageWrapper
import 'package:speak_accounting/quiz_page_wrapper.dart';
import 'package:speak_accounting/video_page.dart';
import 'package:audioplayers/audioplayers.dart'; // Import AudioPlayer

class LessonSectionCard extends StatefulWidget {
  final LessonSection section;
  final Function updateProgress;
  final double? progress;

  const LessonSectionCard({
    super.key,
    required this.section,
    required this.updateProgress,
    this.progress,
  });

  @override
  _LessonSectionCardState createState() => _LessonSectionCardState();
}

class _LessonSectionCardState extends State<LessonSectionCard> {
  // Access AudioPlayer instances (make sure they are accessible from this context)
  final AudioPlayer correctSoundPlayer = AudioPlayer();
  final AudioPlayer incorrectSoundPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadSoundEffects();
  }

  Future<void> _loadSoundEffects() async {
    await correctSoundPlayer.setSourceAsset('assets/sounds/correct');
    await incorrectSoundPlayer.setSourceAsset('assets/sounds/incorrect');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            widget.section.content,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          // Add Quiz button for each section
          if (widget.section.quizQuestions.isNotEmpty)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPageWrapper(
                      quizQuestions: widget.section.quizQuestions,
                      onQuizCompleted: (score, streak) {
                        // Update progress for the section after the quiz
                        widget.updateProgress(1.0);
                        Navigator.pop(context);
                      },
                      // Pass the AudioPlayer instances
                      correctSoundPlayer: correctSoundPlayer,
                      incorrectSoundPlayer: incorrectSoundPlayer,
                    ),
                  ),
                );
              },
              child: const Text('Take Quiz'),
            ),
          const SizedBox(height: 20),
          // Add Video button for each section
          if (widget.section.videoUrl != null)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VideoPage(videoUrl: widget.section.videoUrl!),
                  ),
                ).then((value) {
                  widget.updateProgress(1.0);
                });
              },
              child: const Text('Watch Video'),
            ),
          // Display progress for the section
          if (widget.progress != null)
            Text(
              'Progress: ${widget.progress!.toStringAsFixed(0)}%',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}