import 'dart:math';

import 'package:flutter/material.dart';
import 'package:school_labs/labs/lab1.dart';

const int _wrongAnswersAmount = 3;

class Lab3 extends StatefulWidget {
  const Lab3({super.key});

  @override
  State<Lab3> createState() => _Lab3State();
}

class _Lab3State extends State<Lab3> {
  final Random _random = Random();

  final answers = <double>[];

  int correctAmount = 0;
  int incorrectAmount = 0;
  int maxNumberOfExpression = 10;

  late String expression;
  late double correctAnswer;

  @override
  void initState() {
    super.initState();
    generateExpression();
    generateAnswers();
  }

  void setupQuiz() {
    generateExpression();
    generateAnswers();
    setState(() {});
  }

  void generateExpression() {
    final String operation = operations[_random.nextInt(4)];
    final int firstNum = _random.nextInt(maxNumberOfExpression);
    final int secondNum = _random.nextInt(maxNumberOfExpression);

    final double result =
        calculate(firstNum.toDouble(), secondNum.toDouble(), operation)!;

    final String express = '$firstNum $operation $secondNum = ?';

    expression = express;
    correctAnswer = result;
  }

  void generateAnswers() {
    if (answers.isNotEmpty) answers.clear();

    final shiftOperations = ['-', '+'];

    while (answers.length < _wrongAnswersAmount) {
      String operation = shiftOperations[_random.nextInt(1)];

      final shift = _random.nextInt(6);

      final result =
          calculate(correctAnswer.toDouble(), shift.toDouble(), operation)!;

      if (result == correctAnswer ||
          answers.any((element) => element == result)) continue;

      answers.add(result);
    }

    answers.add(correctAnswer);
    answers.shuffle();
  }

  void onAnswerTap(double answer) {
    if (answer == correctAnswer) {
      correctAmount++;
      if (correctAmount % 5 == 0) {
        maxNumberOfExpression *= 10;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Теперь максимальное число $maxNumberOfExpression'),
          ),
        );
      }
    } else {
      incorrectAmount++;
    }
    setupQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Лаб 3 Семенов Михаил')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                expression,
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ...answers.map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => onAnswerTap(e),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.green),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        (e % 1) == 0.0
                            ? e.toStringAsFixed(0)
                            : e.toStringAsFixed(3),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Правильных ответов: $correctAmount',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Неправильных ответов: $incorrectAmount',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
