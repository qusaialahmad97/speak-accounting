// fill_in_the_blank_question_widget.dart
import 'package:flutter/material.dart';
import 'package:speak_accounting/quiz_question.dart';

class FillInTheBlankQuestionWidget extends StatelessWidget {
  final QuizQuestion question;
  final Function(String) onAnswerSelected;

  const FillInTheBlankQuestionWidget({
    super.key,
    required this.question,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Column(
      children: [
        Text(question.text, style: const TextStyle(fontSize: 18)),
        TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Your answer'),
        ),
        ElevatedButton(
          onPressed: () {
            onAnswerSelected(controller.text);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}