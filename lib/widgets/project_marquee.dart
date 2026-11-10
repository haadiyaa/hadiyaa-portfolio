import 'dart:math' as math;
import 'dart:ui' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import '../core/constants.dart';
import '../core/responsive.dart';
import '../models/models.dart';
import 'project_card.dart';

/// Project cards drifting sideways in an endless loop, edge to edge. It pauses while the cursor is
/// over it or a finger is on it, and can be dragged by hand.
class ProjectMarquee extends StatefulWidget {
  final List<Project> projects;
  const ProjectMarquee(this.projects, {super.key});
  @override
  State<ProjectMarquee> createState() => _ProjectMarqueeState();
}

class _ProjectMarqueeState extends State<ProjectMarquee> with SingleTickerProviderStateMixin {
  late final Ticker ticker;
  ScrollController? controller;
  Duration last = Duration.zero;
  bool hover = false, down = false;

  @override
  void initState() {
    super.initState();
    ticker = createTicker(_tick)..start();
  }

  void _tick(Duration t) {
    final dt = ((t - last).inMicroseconds / 1e6).clamp(0.0, .05).toDouble();
    last = t;
    final c = controller;
    if (hover || down || c == null || !c.hasClients) return;
    c.jumpTo(c.offset + K.marqueeSpeed * dt);
  }

  @override
  void dispose() {
    ticker.dispose();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mob = context.mob, n = widget.projects.length;
    final cardW = mob ? math.min(context.w * .8, 340.0) : 420.0, cardH = mob ? 520.0 : 470.0;
    final extent = cardW + K.gap;
    // The list is endless (card i % n), and starts far from 0 so it can also be dragged backwards.
    controller ??= ScrollController(initialScrollOffset: extent * n * 100);
    return OverflowBox(
        fit: OverflowBoxFit.deferToChild,
        maxWidth: context.w,
        child: SizedBox(
            width: context.w, // breaks out of the page padding to use the full screen width
            height: cardH + 80, // room above and below for the hover lift and glow
            child: MouseRegion(
                onEnter: (_) => hover = true,
                onExit: (_) => hover = false,
                child: Listener(
                    onPointerDown: (_) => down = true,
                    onPointerUp: (_) => down = false,
                    onPointerCancel: (_) => down = false,
                    child: ShaderMask(
                        blendMode: BlendMode.dstIn, // soft fade at both screen edges
                        shaderCallback: (r) => const LinearGradient(colors: [Colors.transparent, Colors.white, Colors.white, Colors.transparent], stops: [0, .06, .94, 1]).createShader(r),
                        child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context).copyWith(
                                scrollbars: false, dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse, PointerDeviceKind.trackpad}),
                            child: ListView.builder(
                                controller: controller,
                                scrollDirection: Axis.horizontal,
                                itemExtent: extent,
                                clipBehavior: Clip.none,
                                padding: const EdgeInsets.symmetric(vertical: 40),
                                itemBuilder: (_, i) => Padding(
                                    padding: const EdgeInsets.only(right: K.gap),
                                    child: ProjectCard(widget.projects[i % n], cardW, height: cardH)))))))));
  }
}