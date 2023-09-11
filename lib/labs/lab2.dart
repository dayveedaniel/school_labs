import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Lab2 extends StatefulWidget {
  Lab2({super.key});

  @override
  State<Lab2> createState() => _Lab2State();
}

class _Lab2State extends State<Lab2> {
  final Random _random = Random();

  final listRandomItems = <int>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lab 2 David Daniel'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: CupertinoButton(
                child: Text('Add Text'),
                color: Colors.grey,
                onPressed: () {
                  listRandomItems.add(_random.nextInt(1000));
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: 20),
            ...listRandomItems.map((e) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'New Random Number $e',
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
