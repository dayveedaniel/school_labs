import 'package:flutter/material.dart';
import 'package:school_labs/labs/lab8/grid/grid_painter.dart';

class Lab8 extends StatelessWidget {
  const Lab8({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Лаб 8 Семенов Михаил')),
      backgroundColor: Colors.black,
      body: const MainGrid(),
    );
  }
}
