import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:haadiya_portfolio/core/theme.dart';

class _Orbs extends CustomPainter {
  final double t;
  final Color a, b;
  _Orbs(this.t, this.a, this.b);
  @override
  void paint(Canvas c, Size s) {
    void orb(Offset o, double r, Color col) => c.drawCircle(o, r,
        Paint()..shader = RadialGradient(colors: [col, Colors.transparent]).createShader(Rect.fromCircle(center: o, radius: r)));
    final k = t * 2 * math.pi;
    orb(Offset(s.width * .82 + math.cos(k) * 90, s.height * .18 + math.sin(k) * 60), 440, a.withValues(alpha: .14));
    orb(Offset(s.width * .08 + math.sin(k) * 70, s.height * .5 + math.cos(k) * 90), 380, b.withValues(alpha: .18));
  }

  @override
  bool shouldRepaint(_Orbs o) => true;
}

class _Glow extends CustomPainter {
  final Offset o;
  final Color col;
  _Glow(this.o, this.col);
  @override
  void paint(Canvas c, Size s) => c.drawCircle(o, 260,
      Paint()..shader = RadialGradient(colors: [col.withValues(alpha: .10), Colors.transparent]).createShader(Rect.fromCircle(center: o, radius: 260)));
  @override
  bool shouldRepaint(_Glow o) => true;
}

/// Drifting colour orbs plus a soft glow that follows the cursor.
class Backdrop extends StatelessWidget {
  final Animation<double> t;
  final ValueNotifier<Offset> mouse;
  const Backdrop(this.t, this.mouse, {super.key});
  @override
  Widget build(BuildContext context) {
    final p = context.p;
    return Stack(children: [
      Positioned.fill(child: AnimatedBuilder(animation: t, builder: (_, __) => CustomPaint(painter: _Orbs(t.value, p.accent, p.glow)))),
      Positioned.fill(
          child: IgnorePointer(
              child: ValueListenableBuilder<Offset>(valueListenable: mouse, builder: (_, o, __) => CustomPaint(painter: _Glow(o, p.accent))))),
    ]);
  }
}
