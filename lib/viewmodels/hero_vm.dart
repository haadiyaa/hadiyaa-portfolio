import 'package:flutter/material.dart';

/// Pointer position as -1..1 from the centre of [area]. Zero until the pointer has moved.
Offset parallax(Offset pointer, Size area) {
  if (pointer.dx < 0 || pointer.dy < 0 || area.isEmpty) return Offset.zero;
  double axis(double v, double size) => (v / size * 2 - 1).clamp(-1.0, 1.0).toDouble();
  return Offset(axis(pointer.dx, area.width), axis(pointer.dy, area.height));
}

/// How far through the pinned hero the page has scrolled, 0..1.
double pinProgress(double offset, double pinExtent) => pinExtent <= 0 ? 0 : (offset / pinExtent).clamp(0.0, 1.0).toDouble();

/// Eased 0..1 value that runs while [p] moves from [a] to [b].
double phase(double p, double a, double b) => Curves.easeOutCubic.transform(((p - a) / (b - a)).clamp(0.0, 1.0).toDouble());

/// Splits "a *b* c" into (a, false), (b, true), (c, false). Starred parts are highlighted.
List<(String, bool)> marked(String s) {
  final parts = s.split('*');
  return [for (var i = 0; i < parts.length; i++) if (parts[i].isNotEmpty) (parts[i], i.isOdd)];
}

/// Opacity of content whose bottom edge is [bottom] px from the top of the screen: fully visible
/// below the fade zone, easing to nothing as it reaches the top.
double exitFade(double bottom, double zone) => zone <= 0 ? 1 : Curves.easeInOut.transform((bottom / zone).clamp(0.0, 1.0).toDouble());