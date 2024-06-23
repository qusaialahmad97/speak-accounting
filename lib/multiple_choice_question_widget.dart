// multiple_choice_question_widget.dart
import 'package:flutter/material.dart';
import 'package:speak_accounting/quiz_question.dart';

class MultipleChoiceQuestionWidget extends StatefulWidget {
  final QuizQuestion question;
  final Function(String) onAnswerSelected;

  const MultipleChoiceQuestionWidget({
    super.key,
    required this.question,
    required this.onAnswerSelected,
  });

  @override
  _MultipleChoiceQuestionWidgetState createState() =>
      _MultipleChoiceQuestionWidgetState();
}

class _MultipleChoiceQuestionWidgetState
    extends State<MultipleChoiceQuestionWidget> {
  String? _selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.question.text, style: const TextStyle(fontSize: 18)),
        Column(
          children: widget.question.options.asMap().entries.map((entry) {
            return RadioListTile<String>(
              title: Text(entry.value),
              value: entry.value, // Store the option as the value
              groupValue: _selectedAnswer, // Use a state variable to manage the selected value
              onChanged: (value) {
                setState(() {
                  _selectedAnswer = value;
                });
                widget.onAnswerSelected(value!);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}