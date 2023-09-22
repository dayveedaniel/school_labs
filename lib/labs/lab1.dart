import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const operations = ['+', '-', '*', '/'];

double? calculate(double? first, double? second, String operation) {
  if (first == null || second == null) {
    return null;
  } else {
    return switch (operation) {
      '+' => first + second,
      '-' => first - second,
      '*' => first * second,
      '/' => first / second,
      _ => null,
    };
  }
}

class Lab1 extends StatefulWidget {
  const Lab1({super.key});

  @override
  State<Lab1> createState() => _Lab1State();
}

class _Lab1State extends State<Lab1> {
  String operation = operations.first;
  double? firstDigit;

  double? secondDigit;

  double? result;

  calculateResult() {
    result = calculate(firstDigit, secondDigit, operation);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lab 1 David Daniel'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      firstDigit =
                          value.isNotEmpty ? double.tryParse(value) : null;
                      calculateResult();
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButton<String>(
                    value: operation,
                    items: operations
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e,
                            child:
                                Text(e, style: const TextStyle(fontSize: 24)),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      operation = value;
                      calculateResult();
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      secondDigit =
                          value.isNotEmpty ? double.tryParse(value) : null;
                      calculateResult();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Text(
                'Ответ: ${result ?? ''}',
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
