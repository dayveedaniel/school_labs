part of 'grid_painter.dart';

const double _gridStep = 80.0;
const double _lineLength = _gridStep * 3;
const double _lineWidth = 1.0;
const double _shadeBlur = 90.0;
const double _shadeSizeCoeff = 1.5;

class GridRenderer {
  GridRenderer({required this.size});

  final Size size;

  final gradientColors = <Color>[
    const Color(0xFF8E81EF).withOpacity(0.0),
    const Color(0xFFB0A7FF),
    const Color(0xFF8E81EF).withOpacity(0.0),
  ];

  final _gridColor = const Color(0xFF151B2B).withOpacity(0.5);

  void drawGrid(Canvas canvas) {
    final linePaint = Paint()
      ..color = _gridColor
      ..strokeWidth = 1.0;

    for (double i = 0; i < size.height; i += _gridStep) {
      canvas.drawLine(Offset(0.0, i), Offset(size.width, i), linePaint);
    }

    for (double i = 0; i < size.width; i += _gridStep) {
      canvas.drawLine(Offset(i, 0.0), Offset(i, size.height), linePaint);
    }
  }

  void drawAnimatedLine(
    Canvas canvas,
    double animationValue,
    int lineNumber,
    bool isHorizontal,
  ) {
    final lineFixedCoord = lineNumber * _gridStep;

    final shadePaint = Paint()
      ..color = Colors.green
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        _shadeBlur,
      );

    if (isHorizontal) {
      _drawHorizontalLine(animationValue, lineFixedCoord, canvas, shadePaint);
    } else {
      _drawVerticalLine(animationValue, lineFixedCoord, canvas, shadePaint);
    }
  }

  void _drawVerticalLine(
    double animationValue,
    double lineFixedCoord,
    Canvas canvas,
    Paint shadePaint,
  ) {
    final lineStart =
        (size.height + _lineLength) * animationValue - _lineLength;
    final lineEnd = lineStart + _lineLength;
    final lineCenter = Offset(lineFixedCoord, lineStart + _lineLength / 2);

    ///Gradient paint of line
    final linePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: gradientColors,
      ).createShader(
        Rect.fromCenter(
          center: lineCenter,
          width: _lineWidth,
          height: _lineLength,
        ),
      );

    ///Shade oval paint
    canvas.drawOval(
      Rect.fromCenter(
        center: lineCenter,
        width: _lineLength / _shadeSizeCoeff,
        height: _lineLength * _shadeSizeCoeff,
      ),
      shadePaint,
    );

    ///Gradient line paint
    canvas.drawLine(
      Offset(lineFixedCoord, lineStart),
      Offset(lineFixedCoord, lineEnd),
      linePaint,
    );
  }

  void _drawHorizontalLine(
    double animationValue,
    double lineFixedCoord,
    Canvas canvas,
    Paint shadePaint,
  ) {
    final lineStart = (size.width + _lineLength) * animationValue - _lineLength;
    final lineEnd = lineStart + _lineLength;
    final lineCenter = Offset(lineStart + _lineLength / 2, lineFixedCoord);

    ///Gradient paint of line
    final linePaint = Paint()
      ..shader = LinearGradient(colors: gradientColors).createShader(
        Rect.fromCenter(
          center: lineCenter,
          width: _lineLength,
          height: _lineWidth,
        ),
      );

    ///Shade oval paint
    canvas.drawOval(
      Rect.fromCenter(
        center: lineCenter,
        width: _lineLength * _shadeSizeCoeff,
        height: _lineLength / _shadeSizeCoeff,
      ),
      shadePaint,
    );

    ///Gradient line paint
    canvas.drawLine(
      Offset(lineStart, lineFixedCoord),
      Offset(lineEnd, lineFixedCoord),
      linePaint,
    );
  }
}
