import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/constants.dart';

/// Fades and lifts its child in once it scrolls into view.
class Reveal extends StatefulWidget {
  final Widget child;
  final int delay;
  const Reveal({super.key, required this.child, this.delay = 0});
  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> {
  bool shown = false, queued = false;
  ScrollPosition? pos;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pos?.removeListener(check);
    pos = Scrollable.maybeOf(context)?.position?..addListener(check);
    WidgetsBinding.instance.addPostFrameCallback((_) => check());
  }

  void check() {
    if (queued || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached || !box.hasSize) return;
    double y;
    try {
      y = box.localToGlobal(Offset.zero).dy;
    } catch (_) {
      return; // an ancestor is not laid out yet; the next scroll or frame retries
    }
    if (y < MediaQuery.of(context).size.height * .92) {
      queued = true;
      Future.delayed(Duration(milliseconds: widget.delay), () {
        if (mounted) setState(() => shown = true);
      });
    }
  }

  @override
  void dispose() {
    pos?.removeListener(check);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedOpacity(
      opacity: shown ? 1 : 0,
      duration: K.revealMs,
      curve: Curves.easeOut,
      child: AnimatedSlide(
          offset: shown ? Offset.zero : const Offset(0, .08),
          duration: K.revealMs,
          curve: Curves.easeOutCubic,
          child: widget.child));
}

/// One piece of the page-load sequence: enters at [start] on the shared [anim] timeline.
class Seq extends StatelessWidget {
  final Animation<double> anim;
  final double start;
  final Widget child;
  const Seq(this.anim, this.start, this.child, {super.key});
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: anim,
      builder: (_, __) {
        final v = Curves.easeOutCubic.transform(Interval(start, math.min(1, start + .35)).transform(anim.value));
        return Opacity(opacity: v, child: Transform.translate(offset: Offset(0, (1 - v) * 24), child: child));
      });
}