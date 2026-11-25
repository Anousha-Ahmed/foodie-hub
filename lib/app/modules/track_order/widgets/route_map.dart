import 'dart:ui';

import 'package:flutter/material.dart';

class RouteMap extends StatelessWidget {
  final double progress;
  const RouteMap({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomPaint(painter: _MapPainter(progress)),
    );
  }
}

class _MapPainter extends CustomPainter {
  final double progress;
  _MapPainter(this.progress);

  static const _bg = Color(0xFFE9EDF2);
  static const _block = Color(0xFFCFD8E3);
  static const _orange = Color(0xFFFF8A00);


  static const _route = [
    Offset(.78, .16),
    Offset(.78, .22),
    Offset(.64, .28),
    Offset(.50, .32),
    Offset(.42, .38),
    Offset(.34, .44),
    Offset(.24, .50),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    Offset p(Offset n) => Offset(n.dx * w, n.dy * h);

    canvas.drawRect(Offset.zero & size, Paint()..color = _bg);

    // Roads
    final road = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9;
    for (final y in [.10, .30, .58, .80]) {
      canvas.drawLine(Offset(0, h * y), Offset(w, h * y), road);
    }
    for (final x in [.14, .46, .70, .92]) {
      canvas.drawLine(Offset(w * x, 0), Offset(w * x, h), road);
    }
    canvas.drawLine(Offset(0, h * .70), Offset(w, h * .42), road);

    // Blocks
    final blockPaint = Paint()..color = _block;
    const blocks = [
      Rect.fromLTWH(.17, .12, .26, .15),
      Rect.fromLTWH(.50, .34, .17, .20),
      Rect.fromLTWH(.73, .60, .17, .17),
      Rect.fromLTWH(.17, .60, .25, .17),
      Rect.fromLTWH(.50, .62, .17, .15),
      Rect.fromLTWH(.02, .33, .09, .22),
      Rect.fromLTWH(.73, .84, .20, .12),
      Rect.fromLTWH(.17, .84, .26, .12),
    ];
    for (final b in blocks) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(b.left * w, b.top * h, b.width * w, b.height * h),
            const Radius.circular(8)),
        blockPaint,
      );
    }

    // Lake + roundabout
    canvas.drawOval(
        Rect.fromLTWH(w * .62, h * .06, w * .32, h * .10), blockPaint);
    canvas.drawCircle(
        Offset(w * .20, h * .45),
        w * .09,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8);

    // Route
    final path = Path()..moveTo(p(_route.first).dx, p(_route.first).dy);
    for (final pt in _route.skip(1)) {
      path.lineTo(p(pt).dx, p(pt).dy);
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = _orange
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    // Restaurant (start) - khali gol
    final start = p(_route.first);
    canvas.drawCircle(start, 6, Paint()..color = Colors.white);
    canvas.drawCircle(
        start,
        6,
        Paint()
          ..color = _orange
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3);

    // Customer (end) - laal pin
    final end = p(_route.last);
    canvas.drawCircle(end, 20, Paint()..color = const Color(0xFFF44336));
    final icon = Icons.location_on;
    final tp = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
            fontFamily: icon.fontFamily, fontSize: 22, color: Colors.white),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, end - Offset(tp.width / 2, tp.height / 2));

    // Rider - route par progress ke hisaab se
    final metric = path.computeMetrics().first;
    final tangent = metric.getTangentForOffset(metric.length * progress);
    if (tangent != null) {
      final r = tangent.position;
      canvas.drawCircle(r, 24, Paint()..color = _orange.withOpacity(0.18));
      canvas.drawCircle(r, 17, Paint()..color = _orange.withOpacity(0.30));
      canvas.drawCircle(r, 11, Paint()..color = const Color(0xFFF5B83D));
      canvas.drawCircle(
          r,
          11,
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2);
    }
  }

  @override
  bool shouldRepaint(covariant _MapPainter old) => old.progress != progress;
}