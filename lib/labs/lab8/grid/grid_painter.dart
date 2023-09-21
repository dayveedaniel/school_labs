import 'dart:math';

import 'package:flutter/material.dart';

part 'grid_renderer.dart';

///Better to rewrite to bloc

class GridPainter extends CustomPainter {
  GridPainter({
    required this.animationValue,
    required this.verticalLine,
    required this.horizontalLine,
    required this.setVerticalLine,
    required this.setHorizontalLine,
  });

  final double animationValue;

  final int verticalLine;
  final int horizontalLine;

  final void Function(int) setVerticalLine;
  final void Function(int) setHorizontalLine;

  @override
  void paint(Canvas canvas, Size size) {
    final renderer = GridRenderer(size: size);

    renderer.drawGrid(canvas);

    final int amountOfHorizontals = size.height ~/ _gridStep;
    final int amountOfVerticals = size.width ~/ _gridStep;

    ///when the animation starts, we need to get a random line number
    if (animationValue == 0.0) {
      setVerticalLine(Random().nextInt(amountOfVerticals));
      setHorizontalLine(Random().nextInt(amountOfHorizontals));
    } else {
      renderer.drawAnimatedLine(canvas, animationValue, verticalLine, false);
      renderer.drawAnimatedLine(canvas, animationValue, horizontalLine, true);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MainGrid extends StatefulWidget {
  const MainGrid({super.key});

  @override
  State<MainGrid> createState() => _MainGridState();
}

class _MainGridState extends State<MainGrid>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  int horizontalLineNumber = 1;
  int verticalLineNumber = 1;

  @override
  void initState() {
    _initAnimation();

    _controller.addListener(() async {
      _resetAnimation();
    });

    _controller.forward(from: 0.0);
    super.initState();
  }

  void _initAnimation() {
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  void _resetAnimation() async {
    if (_animation.isCompleted) {
      _controller.reset();
      await Future.delayed(const Duration(seconds: 1));
      _controller.forward(from: 0.0);
    }
    setState(() {});
  }

  void _setHorizontalLine(int line) => horizontalLineNumber = line;

  void _setVerticalLine(int line) => verticalLineNumber = line;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.maxFinite, double.maxFinite),
      painter: GridPainter(
        animationValue: _animation.value,
        horizontalLine: horizontalLineNumber,
        verticalLine: verticalLineNumber,
        setHorizontalLine: _setHorizontalLine,
        setVerticalLine: _setVerticalLine,
      ),
    );
  }
}
