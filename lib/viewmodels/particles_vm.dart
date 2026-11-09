import 'dart:math' as math;
import 'dart:typed_data';

/// The character as a cloud of particles. Pure Dart, so it can be tested without a screen.
/// Positions are in source-image pixels. Each particle has a home (where it sits when the image is
/// formed) and a scatter spot (where it floats when the image has dissolved).
class ParticleField {
  final int count, w, h, cell;
  final Float32List hx, hy, sx, sy, delay, x, y, vx, vy;
  final Int32List colors6; // ARGB for the six vertices of every particle's quad

  ParticleField._(this.count, this.w, this.h, this.cell, this.hx, this.hy, this.sx, this.sy, this.delay, this.x, this.y, this.vx, this.vy, this.colors6);

  /// One particle per [step] px of [rgba] (w x h, 4 bytes a pixel) wherever the pixel is mostly opaque.
  factory ParticleField.fromRgba(Uint8List rgba, int w, int h, int step, {int seed = 7}) {
    final rnd = math.Random(seed);
    final hxs = <double>[], hys = <double>[], cols = <int>[];
    for (var j = step ~/ 2; j < h; j += step) {
      for (var i = step ~/ 2; i < w; i += step) {
        final o = (j * w + i) * 4;
        if (rgba[o + 3] < 128) continue;
        hxs.add(i.toDouble());
        hys.add(j.toDouble());
        cols.add(0xFF000000 | (rgba[o] << 16) | (rgba[o + 1] << 8) | rgba[o + 2]);
      }
    }
    final n = hxs.length, big = math.max(w, h).toDouble();
    final f = Float32List.fromList;
    final sx = Float32List(n), sy = Float32List(n), delay = Float32List(n), colors6 = Int32List(n * 6);
    for (var i = 0; i < n; i++) {
      final angle = rnd.nextDouble() * 2 * math.pi, radius = (.25 + rnd.nextDouble() * .75) * big * .9;
      sx[i] = hxs[i] + math.cos(angle) * radius;
      sy[i] = hys[i] + math.sin(angle) * radius;
      delay[i] = rnd.nextDouble() * .45;
      colors6.fillRange(i * 6, i * 6 + 6, cols[i]);
    }
    // Particles start in their scatter spots, so the image visibly flies together on load.
    return ParticleField._(n, w, h, step, f(hxs), f(hys), sx, sy, delay, Float32List.fromList(sx), Float32List.fromList(sy), Float32List(n), Float32List(n), colors6);
  }

  /// Advances every particle by [dt] seconds.
  /// [assembled] 1 = image formed, 0 = fully dissolved. [lift] 0..1 = how far the cloud has risen.
  /// [px], [py] = cursor in image pixels (null when there is no cursor) pushes particles away.
  void step(double assembled, double lift, double dt, double? px, double? py, {double radiusShare = .14, double force = 12000}) {
    const k = 70.0, damp = 9.0; // spring pull towards the target, and friction
    final liftY = -lift * h * 1.15, r = h * radiusShare, r2 = r * r;
    for (var i = 0; i < count; i++) {
      final a = (assembled * 1.5 - delay[i]).clamp(0.0, 1.0), e = a * a * (3 - 2 * a); // staggered, eased
      final tx = sx[i] + (hx[i] - sx[i]) * e, ty = sy[i] + (hy[i] - sy[i]) * e + liftY;
      var ax = (tx - x[i]) * k - vx[i] * damp, ay = (ty - y[i]) * k - vy[i] * damp;
      if (px != null && py != null) {
        final dx = x[i] - px, dy = y[i] - py, d2 = dx * dx + dy * dy;
        if (d2 < r2 && d2 > 1) {
          final d = math.sqrt(d2), f = 1 - d / r;
          ax += dx / d * f * f * force;
          ay += dy / d * f * f * force;
        }
      }
      vx[i] += ax * dt;
      vy[i] += ay * dt;
      x[i] += vx[i] * dt;
      y[i] += vy[i] * dt;
    }
  }
}