import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import '../core/constants.dart';
import '../core/responsive.dart';
import '../core/theme.dart';

/// The huge background word. Its letters come out one by one as [intro] plays.
/// One line on wide screens, two lines on phones.
class HeroWord extends StatelessWidget {
  final Animation<double> intro;
  const HeroWord(this.intro, {super.key});

  Widget _letter(String ch, int i, double size, TextStyle style) => AnimatedBuilder(
      animation: intro,
      builder: (_, __) {
        final v = Curves.easeOutCubic.transform(Interval(i * .06, i * .06 + .3).transform(intro.value));
        return Opacity(opacity: v, child: Transform.translate(offset: Offset(0, (1 - v) * size * .8), child: Text(ch, style: style)));
      });

  @override
  Widget build(BuildContext context) {
    final p = context.p, mob = context.mob;
    final size = mob ? context.w * .40 : 400.0;
    final wide = math.min(context.w * .98, context.h * 2.4); // may break out of the page padding
    final style = GoogleFonts.bricolageGrotesque(fontSize: size, fontWeight: FontWeight.w800, height: .85, letterSpacing: -size * .04, color: Colors.white);
    var n = 0;
    final lines = [
      for (final line in mob ? K.heroWordMobile : [K.heroWord])
        FittedBox(fit: mob ? BoxFit.scaleDown : BoxFit.fitWidth, child: Row(mainAxisSize: MainAxisSize.min, children: [for (final ch in line.split('')) _letter(ch, n++, size, style)])),
    ];
    return OverflowBox(
        fit: OverflowBoxFit.deferToChild,
        maxWidth: context.w,
        child: SizedBox(
            width: mob ? context.w : wide,
            // Taller than natural. The fade sits inside the stretch so it stretches too, and it covers the whole word.
            child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.diagonal3Values(1, K.heroWordStretch, 1),
                child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (r) => LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [p.ink.withOpacity(.6), p.ink.withOpacity(.06)]).createShader(r),
                    child: Column(mainAxisSize: MainAxisSize.min, children: lines)))));
  }
}