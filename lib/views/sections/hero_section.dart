import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:haadiya_portfolio/widgets/particle_character.dart';
import '../../core/constants.dart';
import '../../core/responsive.dart';
import '../../viewmodels/hero_vm.dart';
import '../../widgets/floating_character.dart';
import '../../widgets/hero_intro.dart';
import '../../widgets/hero_name.dart';
import '../../widgets/hero_word.dart';
import '../../widgets/scroll_hint.dart';

/// The hero stays pinned for a while as you scroll: the character lifts away and the intro
/// is revealed under the big word. Then the hero scrolls off and the page carries on.
/// [scroll] is the page's scroll controller.
class HeroSection extends StatelessWidget {
  final Animation<double> intro, loop;
  final ValueNotifier<Offset> mouse;
  final ScrollController scroll;
  const HeroSection(this.intro, this.loop, this.mouse, this.scroll, {super.key});

  double _fade(double t, double a, double b) => Curves.easeOut.transform(Interval(a, b).transform(t));

  @override
  Widget build(BuildContext context) {
    final h = context.h, pin = context.pin;
    // The hero is a fixed layer behind the page. The page starts with a spacer as tall as the hero
    // plus the pinned distance, so the hero stays put while that spacer scrolls by, then lifts away.
    return SizedBox(
        height: h,
        width: double.infinity,
        child: AnimatedBuilder(
            animation: scroll,
            builder: (_, __) {
              final offset = scroll.hasClients ? scroll.offset : 0.0;
              return Transform.translate(
                  offset: Offset(0, -(offset - pin).clamp(0.0, h).toDouble()),
                  child: _stage(context, pinProgress(offset, pin)));
            }));
  }

  Widget _stage(BuildContext context, double p) {
    final h = context.h, area = Size(context.w, h), mob = context.mob;
    final charH = mob ? math.min(context.w * .95 / K.characterAspect, h * .5) : math.min(h * .64, 640.0);
    return ValueListenableBuilder<Offset>(
        valueListenable: mouse,
        builder: (_, pointer, __) => TweenAnimationBuilder<Offset>(
            tween: Tween(end: parallax(pointer, area)),
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOut,
            builder: (_, o, __) => AnimatedBuilder(
                animation: intro,
                builder: (_, __) => Stack(clipBehavior: Clip.none, children: [
                      // Label and word stay still and ignore the cursor. Only the character follows it.
                      Align(alignment: const Alignment(0, -.8), child: Opacity(opacity: _fade(intro.value, .1, .5), child: const HeroName(K.heroLabel))),
                      Align(alignment: const Alignment(0, -.25), child: HeroWord(intro)),
                      Align(alignment: Alignment(0, mob ? .55 : .5), child: HeroIntro(p)),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                              padding: const EdgeInsets.only(bottom: 36),
                              child: Column(mainAxisSize: MainAxisSize.min, children: [
                                // She forms from particles on load, and as you scroll she dissolves back into
                                // particles that drift up and fade (the particles do the lifting themselves).
                                Opacity(
                                    opacity: 1 - phase(p, .6, .98),
                                    child: Transform(
                                            alignment: Alignment.center,
                                            transform: Matrix4.identity()
                                              ..setEntry(3, 2, .0012) // perspective
                                              ..translate(o.dx * K.charShift.dx, o.dy * K.charShift.dy)
                                              ..rotateX(o.dy * K.charTilt.dy) // cursor below: top tips forward
                                              ..rotateY(-o.dx * K.charTilt.dx), // cursor right: right side turns away, so she faces it
                                            child: FloatingCharacter(loop, charH,
                                                shadowOpacity: _fade(intro.value, .75, 1) * (1 - phase(p, 0, .3)),
                                                image: ParticleCharacter(width: charH * K.characterAspect, height: charH, lift: p, mouse: mouse)))),
                                const SizedBox(height: 14),
                                Opacity(opacity: _fade(intro.value, .75, 1), child: HeroName(K.name.toUpperCase())),
                              ]))),
                      if (!mob)
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 40),
                                child: Opacity(opacity: _fade(intro.value, .8, 1) * (1 - phase(p, 0, .15)), child: const ScrollHint(K.scrollHint)))),
                    ]))));
  }
}