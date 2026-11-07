import 'package:flutter/material.dart';

/// Pointer position as -1..1 from the centre of [area]. Zero until the pointer has moved.
Offset parallax(Offset pointer, Size area) {
  if (pointer.dx < 0 || pointer.dy < 0 || area.isEmpty) return Offset.zero;
  double axis(double v, double size) => (v / size * 2 - 1).clamp(-1.0, 1.0).toDouble();
  return Offset(axis(pointer.dx, area.width), axis(pointer.dy, area.height));
}