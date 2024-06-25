// lesson_card.dart
import 'package:flutter/material.dart';
// Import QuizPageWrapper
import 'package:audioplayers/audioplayers.dart'; // Import AudioPlayer
import 'package:speak_accounting/quiz_page_wrapper.dart';
import '/lesson.dart';
import '/lesson_details_page.dart';

class LessonCard extends StatefulWidget {
  final Lesson lesson;
  final Function updateProgress;
  final Map<String, dynamic>? progress;

  const LessonCard({
    super.key,
    required this.lesson,
    required this.updateProgress,
    this.progress,
  });

  @override
  _LessonCardState createState() => _LessonCardState();
}

class _LessonCardState extends State<LessonCard> {
  // Add a state variable to hold the current progress of the lesson
  Map<String, dynamic>? _lessonProgress;

  // Access AudioPlayer instances (make sure they are accessible from this context)
  final AudioPlayer correctSoundPlayer = AudioPlayer();
  final AudioPlayer incorrectSoundPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // Load initial progress from database
    _updateLessonProgress();
    _loadSoundEffects();
  }

  // Function to update the _lessonProgress state
  void _updateLessonProgress() {
    setState(() {
      // Update progress based on progress map passed from LessonDetailsPage
      _lessonProgress = widget.progress;
    });
  }

  Future<void> _loadSoundEffects() async {
    await correctSoundPlayer.setSourceAsset('assets/sounds/correct.mp3');
    await incorrectSoundPlayer.setSourceAsset('assets/sounds/incorrect.mp3');
  }

  void _onQuizCompleted(int score, int streak) {
    // Handle the quiz completion logic here
    // For example, update progress for the lesson
    widget.updateProgress(widget.lesson.title, "quiz", 1.0);
  }

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
              builder: (context) => LessonDetailsPage(
                lesson: widget.lesson,
                updateProgress: widget.updateProgress,
                progress: widget.progress,
              ),
            ),
          ).then((value) {
            // Update progress after returning from the details page
            _updateLessonProgress();
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.lesson.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Progress bar for the entire lesson
              LinearProgressIndicator(
                value: widget.lesson.getAverageProgress(_lessonProgress),
                minHeight: 10,
                backgroundColor: Colors.grey[300],
                valueColor:
                const AlwaysStoppedAnimation(Colors.deepPurpleAccent),
              ),
              const SizedBox(height: 8),
              // Display the number of completed sections
              Text(
                '${widget.lesson.getCompletedSectionCount(_lessonProgress)} / ${widget.lesson.sections.length} Sections Completed',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              // Display check icon if all sections are completed
              if (widget.lesson.sections.any((section) =>
              _lessonProgress?[section.title] == 1.0))
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 24,
                )
              else
                const SizedBox.shrink(),
              const SizedBox(height: 10),
              // Quiz button for the entire lesson
              if (widget.lesson.sections.any(
                      (section) => section.quizQuestions.isNotEmpty))
                ElevatedButton(
                  onPressed: () {
                    // Navigate to a QuizPage for the entire lesson
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizPageWrapper(
                          quizQuestions: widget.lesson.sections
                              .expand((section) => section.quizQuestions)
                              .toList(), // Pass the quiz questions
                          onQuizCompleted: _onQuizCompleted,
                          // Pass the AudioPlayer instances
                          correctSoundPlayer: correctSoundPlayer,
                          incorrectSoundPlayer: incorrectSoundPlayer,
                        ),
                      ),
                    ).then((value) {
                      // Update progress for the entire lesson (consider a different logic for this)
                      // updateProgress(lesson.title, 1.0);
                    });
                  },
                  child: const Text('Take Quiz'),
                ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}