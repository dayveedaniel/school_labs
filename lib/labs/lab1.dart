import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const operations = ['+', '-', '*', '/'];

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
    if (firstDigit == null || secondDigit == null) {
      result = null;
    } else {
      result = switch (operation) {
        '+' => firstDigit! + secondDigit!,
        '-' => firstDigit! - secondDigit!,
        '*' => firstDigit! * secondDigit!,
        '/' => firstDigit! / secondDigit!,
        String() => null,
      };
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lab 1 David Daniel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(
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
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: operation,
                  items: operations
                      .map((e) => DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    operation = value;
                    calculateResult();
                  },
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(
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
                ),
              ],
            ),
            SizedBox(height: 50),
            Text(
              'Result : ${result ?? ''}',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
