import 'package:flutter/material.dart';
import 'package:school_labs/labs/lab1.dart';
import 'package:school_labs/labs/lab4.dart';
import 'package:school_labs/labs/lab5/lab5.dart';
import 'package:school_labs/labs/lab6/lab6.dart';
import 'package:school_labs/labs/lab7/lab7.dart';
import 'package:school_labs/labs/lab8/lab8.dart';

import 'labs/lab2.dart';
import 'labs/lab3.dart';

const labs = [
  Lab1(),
  Lab2(),
  Lab3(),
  Lab4(),
  Lab5(),
  Lab6(),
  Lab7(),
  Lab8(),
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: labs.length,
        itemBuilder: (_, index) => ListTile(
          title: Text('Лабораторная ${index + 1}'),
          shape: const Border(bottom: BorderSide(color: Colors.green)),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => labs[index]),
          ),
        ),
      ),
    );
  }
}
