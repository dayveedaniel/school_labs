import 'dart:math';

import 'package:flutter/material.dart';

class Lab2 extends StatefulWidget {
  const Lab2({super.key});

  @override
  State<Lab2> createState() => _Lab2State();
}

class _Lab2State extends State<Lab2> {
  final Random _random = Random();

  final randoms = <int>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Лаб 2 Семенов Михаил')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: MaterialButton(
                color: Colors.green[700],
                onPressed: () {
                  randoms.add(_random.nextInt(10000));
                  setState(() {});
                },
                child: const Text(
                  'Добавить Text',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ...randoms.map(
              (e) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Число $e',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
