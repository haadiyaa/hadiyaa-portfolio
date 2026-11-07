import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../core/responsive.dart';
import '../../viewmodels/hero_vm.dart';
import '../../widgets/floating_character.dart';
import '../../widgets/hero_name.dart';
import '../../widgets/hero_word.dart';

/// The big background word, the floating character and the name under her.
class HeroSection extends StatelessWidget {
  final Animation<double> intro, loop;
  final ValueNotifier<Offset> mouse;
  const HeroSection(this.intro, this.loop, this.mouse, {super.key});

  double _fade(double t, double a, double b) => Curves.easeOut.transform(Interval(a, b).transform(t));

  @override
  Widget build(BuildContext context) {
    final h = context.h, area = Size(context.w, h);
    final charH = context.mob ? math.min(context.w * .95 / K.characterAspect, h * .5) : math.min(h * .64, 640.0);
    return SizedBox(
        height: h,
        width: double.infinity,
        child: ValueListenableBuilder<Offset>(
            valueListenable: mouse,
            builder: (_, pointer, __) => TweenAnimationBuilder<Offset>(
                tween: Tween(end: parallax(pointer, area)),
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOut,
                builder: (_, o, __) => AnimatedBuilder(
                    animation: intro,
                    builder: (_, __) => Stack(clipBehavior: Clip.none, children: [
                          // Letters come out one by one (see HeroWord), then the image and the name fade in.
                          Align(alignment: const Alignment(0, -.25), child: Transform.translate(offset: Offset(-o.dx * 22, -o.dy * 14), child: HeroWord(intro))),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                  padding: const EdgeInsets.only(bottom: 36),
                                  child: Transform.translate(
                                      offset: Offset(o.dx * 8, o.dy * 5),
                                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                                        Opacity(opacity: _fade(intro.value, .55, 1), child: FloatingCharacter(loop, charH)),
                                        const SizedBox(height: 14),
                                        Opacity(opacity: _fade(intro.value, .75, 1), child: const HeroName()),
                                      ])))),
                        ])))));
  }
}