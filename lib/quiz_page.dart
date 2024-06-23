// quiz_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:speak_accounting/lesson.dart';
import 'package:speak_accounting/quiz_card.dart';
import 'package:speak_accounting/quiz_question.dart';
import 'package:speak_accounting/multiple_choice_question_widget.dart';
import 'package:speak_accounting/true_false_question_widget.dart';
import 'package:speak_accounting/fill_in_the_blank_question_widget.dart';
import 'package:speak_accounting/lesson_page.dart';
import 'package:speak_accounting/video_page.dart';
import 'package:speak_accounting/quiz_result_page.dart'; // Import QuizResultPage
import 'package:speak_accounting/leaderboard_page.dart'; // Import LeaderboardPage

class QuizPage extends StatefulWidget {
  final List<Lesson> lessons; // Receive lessons from LessonPage

  const QuizPage({super.key, required this.lessons});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference progressCollection =
  FirebaseFirestore.instance.collection('progress');
  final CollectionReference analyticsCollection =
  FirebaseFirestore.instance.collection('quiz_analytics');
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  // List of quiz categories (now using Lesson data)
  List<QuizCard> _quizCategories = [];

  @override
  void initState() {
    super.initState();
    _createQuizCategories(); // Create QuizCards from lessons
  }

  void _createQuizCategories() {
    _quizCategories = widget.lessons
        .map((lesson) => QuizCard(
      title: lesson.title,
      imageUrl: lesson.sections.isNotEmpty
          ? lesson.sections[0].imageUrl
          : null,
      quizQuestions: lesson.sections
          .expand((section) => section.quizQuestions)
          .toList(),
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounting Quizzes',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.purple[900], // Deeper purple

        actions: [
          IconButton(
            icon: const Icon(Icons.leaderboard,color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LeaderboardPage(), // Navigate to LeaderboardPage
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: _quizCategories.map((quizCategory) {
          return QuizCardWidget(
            quizCard: quizCategory,
            onQuizSelected: (quizQuestions) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizPageInternal(
                    quizQuestions: quizQuestions,
                    onQuizCompleted: (score, streak) {
                      _updateXP(); // Update XP when quiz is completed
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizResultPage(
                            score: score,
                            totalQuestions: quizQuestions.length,
                            streak: streak,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Future<void> _updateXP() async {
    if (user != null) {
      final String uid = user!.uid;
      DocumentSnapshot userDoc = await usersCollection.doc(uid).get();
      int currentXP = userDoc.get('xp') ?? 0; // Get existing XP or default to 0
      await usersCollection.doc(uid).update({'xp': currentXP + 15});
    }
  }
}

// Internal Quiz Page
class QuizPageInternal extends StatefulWidget {
  final List<QuizQuestion> quizQuestions;
  final Function(int, int) onQuizCompleted;

  const QuizPageInternal({
    super.key,
    required this.quizQuestions,
    required this.onQuizCompleted,
  });

  @override
  _QuizPageInternalState createState() => _QuizPageInternalState();
}

class _QuizPageInternalState extends State<QuizPageInternal> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  final User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference progressCollection =
  FirebaseFirestore.instance.collection('progress');
  final CollectionReference analyticsCollection =
  FirebaseFirestore.instance.collection('quiz_analytics');

  Timer? _timer;
  int _timeRemaining = 15;
  int _streak = 0;

  final Map<int, String> _answeredQuestions = {};
  String? _selectedAnswer; // Store the currently selected answer

  bool _showFeedback = false;
  String _feedbackMessage = "";
  Color _feedbackColor = Colors.green;
  String _buttonText = "Check"; // Initial button text is "Check"

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeRemaining--;
        if (_timeRemaining == 0) {
          _endQuiz();
        }
      });
    });
  }

  void _endQuiz() {
    _timer?.cancel();
    _saveProgress();
    widget.onQuizCompleted(_score, _streak);
  }

  void _checkAnswer() {
    setState(() {
      _showFeedback = true; // Show feedback container when "Check" is pressed
      final String answer = _selectedAnswer ?? "";

      // Debug print to check the selected answer and correct answer
      print('Selected Answer: $answer');
      print(
          'Correct Answer: ${widget.quizQuestions[_currentQuestionIndex].correctAnswer}');

      if (answer ==
          widget.quizQuestions[_currentQuestionIndex].correctAnswer) {
        _score++;
        _streak++;
        _feedbackMessage = "Correct!";
        _feedbackColor = Colors.green;
        _buttonText = "Continue"; // Change button text to "Continue"
      } else {
        _streak = 0;
        _updateAnalytics(
            widget.quizQuestions[_currentQuestionIndex].text, answer);
        _feedbackMessage =
        "Incorrect. The correct answer is: ${widget.quizQuestions[_currentQuestionIndex].correctAnswer}";
        _feedbackColor = Colors.red;
        _buttonText = "Got it";
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _showFeedback = false; // Hide feedback container
      _selectedAnswer = null;
      _currentQuestionIndex++;

      if (_currentQuestionIndex >= widget.quizQuestions.length) {
        _endQuiz();
      } else {
        _buttonText = "Check"; // Reset button text to "Check"
      }
    });
  }

  void _saveProgress() {
    if (user != null) {
      final String uid = user!.uid;
      progressCollection.doc(uid).set({
        'score': _score,
        'quizCompleted': true,
        'streak': _streak,
      });
    }
  }

  void _updateAnalytics(String question, String givenAnswer) {
    analyticsCollection.add({
      'question': question,
      'givenAnswer': givenAnswer,
      'timestamp': Timestamp.now(),
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex >= widget.quizQuestions.length) {
      return Center(
        child: Text(
          'Quiz Completed!\nScore: $_score\nStreak: $_streak',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      );
    }

    final currentQuestion = widget.quizQuestions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Question ${_currentQuestionIndex + 1} / ${widget.quizQuestions.length}',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF4B188C),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (currentQuestion.imageUrl != null)
                        Image.asset(
                          currentQuestion.imageUrl!,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      const SizedBox(height: 16),
                      if (currentQuestion.type == QuizType.multipleChoice)
                        MultipleChoiceQuestionWidget(
                          question: currentQuestion,
                          onAnswerSelected: (answer) {
                            setState(() {
                              _selectedAnswer = answer;
                              // Debug print to verify answer selection
                              print('Answer selected: $answer');
                            });
                          },
                        ),
                      if (currentQuestion.type == QuizType.trueFalse)
                        TrueFalseQuestionWidget(
                          question: currentQuestion,
                          onAnswerSelected: (answer) {
                            setState(() {
                              _selectedAnswer = answer;
                              // Debug print to verify answer selection
                              print('Answer selected: $answer');
                            });
                          },
                        ),
                      if (currentQuestion.type == QuizType.fillInTheBlank)
                        FillInTheBlankQuestionWidget(
                          question: currentQuestion,
                          onAnswerSelected: (answer) {
                            setState(() {
                              _selectedAnswer = answer;
                              // Debug print to verify answer selection
                              print('Answer selected: $answer');
                            });
                          },
                        ),
                      const SizedBox(height: 16),
                      Text(
                        'Time remaining: $_timeRemaining seconds',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _buttonText == "Continue"
                            ? _nextQuestion
                            : _checkAnswer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: _feedbackColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Text(_buttonText),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _showFeedback ? 100 : 0,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              color: _feedbackColor,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_showFeedback)
                      Text(
                        _feedbackMessage,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
