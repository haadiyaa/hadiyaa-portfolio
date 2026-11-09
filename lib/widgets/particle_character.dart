import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import '../core/constants.dart';
import '../viewmodels/hero_vm.dart';
import '../viewmodels/particles_vm.dart';

/// The character made of particles. On load they fly together into the image, and a crisp copy
/// fades in once it has formed. As [lift] grows (scrolling) it dissolves back into particles that
/// drift up. While they are particles the cursor pushes them away.
class ParticleCharacter extends StatefulWidget {
  final double width, height, lift;
  final ValueNotifier<Offset> mouse;
  const ParticleCharacter({super.key, required this.width, required this.height, required this.lift, required this.mouse});
  @override
  State<ParticleCharacter> createState() => _ParticleCharacterState();
}

class _ParticleCharacterState extends State<ParticleCharacter> with SingleTickerProviderStateMixin {
  late final Ticker ticker;
  final frame = ValueNotifier<int>(0), crisp = ValueNotifier<double>(0);
  ParticleField? field;
  _Painter? painter;
  Duration last = Duration.zero;
  double formT = 0;

  @override
  void initState() {
    super.initState();
    ticker = createTicker(_tick)..start();
    _load();
  }

  Future<void> _load() async {
    try {
      final data = await rootBundle.load(K.characterAsset);
      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: K.particleSample);
      final image = (await codec.getNextFrame()).image;
      final bytes = (await image.toByteData(format: ui.ImageByteFormat.rawRgba))!;
      final f = ParticleField.fromRgba(bytes.buffer.asUint8List(), image.width, image.height, K.particleStep);
      if (mounted) setState(() => field = f);
    } catch (_) {
      if (mounted) crisp.value = 1; // could not build particles: just show the image
    }
  }

  void _tick(Duration t) {
    final f = field;
    final dt = ((t - last).inMicroseconds / 1e6).clamp(0.0, 1 / 30).toDouble();
    last = t;
    if (f == null) return;
    if (t.inMilliseconds > 300) formT = (formT + dt / K.particleFormSeconds).clamp(0.0, 1.0).toDouble();
    final lift = widget.lift, a = (formT * formT * (3 - 2 * formT)) * (1 - phase(lift, .02, .55));
    crisp.value = ((a - .97) / .03).clamp(0.0, 1.0).toDouble();
    if (crisp.value >= 1 && lift < .001) return; // formed and still: nothing to animate
    double? px, py;
    final box = context.findRenderObject() as RenderBox?, m = widget.mouse.value, scale = widget.height / f.h;
    if (box != null && box.hasSize && m.dx >= 0 && m.dy >= 0) {
      final l = box.globalToLocal(m);
      px = l.dx / scale;
      py = l.dy / scale;
    }
    f.step(a, lift, dt, px, py, radiusShare: K.particleRepelRadius, force: K.particleRepelForce);
    frame.value++;
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final f = field;
    if (f != null && (painter == null || painter!.scale != widget.height / f.h)) painter = _Painter(f, widget.height / f.h, frame);
    return SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(children: [
          ValueListenableBuilder<double>(
              valueListenable: crisp,
              builder: (_, c, __) => Opacity(
                  opacity: c,
                  child: Image.asset(K.characterAsset,
                      width: widget.width, height: widget.height, fit: BoxFit.contain, filterQuality: FilterQuality.high,
                      errorBuilder: (_, __, ___) => const SizedBox.shrink()))),
          if (painter != null)
            ValueListenableBuilder<double>(
                valueListenable: crisp,
                builder: (_, c, __) => c >= 1 ? const SizedBox.shrink() : CustomPaint(size: Size(widget.width, widget.height), painter: painter)),
        ]));
  }
}

/// Draws every particle as a small square with one batched call.
class _Painter extends CustomPainter {
  final ParticleField f;
  final double scale;
  final Float32List buf;
  _Painter(this.f, this.scale, Listenable repaint)
      : buf = Float32List(f.count * 12),
        super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    final hs = f.cell * scale * .55; // slightly more than half a cell, so a formed image has no gaps
    var o = 0;
    for (var i = 0; i < f.count; i++) {
      final x = f.x[i] * scale, y = f.y[i] * scale;
      buf[o++] = x - hs; buf[o++] = y - hs; buf[o++] = x + hs; buf[o++] = y - hs; buf[o++] = x - hs; buf[o++] = y + hs;
      buf[o++] = x + hs; buf[o++] = y - hs; buf[o++] = x + hs; buf[o++] = y + hs; buf[o++] = x - hs; buf[o++] = y + hs;
    }
    final v = ui.Vertices.raw(ui.VertexMode.triangles, buf, colors: f.colors6);
    canvas.drawVertices(v, BlendMode.src, Paint());
    v.dispose();
  }

  @override
  bool shouldRepaint(_Painter old) => true;
}