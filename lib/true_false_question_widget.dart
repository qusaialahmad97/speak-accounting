// true_false_question_widget.dart
import 'package:flutter/material.dart';
import 'package:speak_accounting/quiz_question.dart';

class TrueFalseQuestionWidget extends StatefulWidget {
  final QuizQuestion question;
  final Function(String) onAnswerSelected;

  const TrueFalseQuestionWidget({
    super.key,
    required this.question,
    required this.onAnswerSelected,
  });

  @override
  _TrueFalseQuestionWidgetState createState() =>
      _TrueFalseQuestionWidgetState();
}

class _TrueFalseQuestionWidgetState extends State<TrueFalseQuestionWidget> {
  String? _selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.question.text, style: const TextStyle(fontSize: 18)),
        RadioListTile<String>(
          title: const Text('True'),
          value: 'True',
          groupValue: _selectedAnswer, // Use a state variable to manage the selected value
          onChanged: (value) {
            setState(() {
              _selectedAnswer = value;
            });
            widget.onAnswerSelected(value!);
          },
        ),
        RadioListTile<String>(
          title: const Text('False'),
          value: 'False',
          groupValue: _selectedAnswer, // Use a state variable to manage the selected value
          onChanged: (value) {
            setState(() {
              _selectedAnswer = value;
            });
            widget.onAnswerSelected(value!);
          },
        ),
      ],
    );
  }
}