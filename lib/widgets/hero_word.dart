import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants.dart';
import '../core/responsive.dart';
import '../core/theme.dart';

/// The huge background word. Its letters come out one by one as [intro] plays, and the whole word
/// fades out completely towards the bottom so the character and the name in front stay clear.
/// One line on wide screens, two lines on phones.
class HeroWord extends StatelessWidget {
  final Animation<double> intro;
  const HeroWord(this.intro, {super.key});

  Widget _letter(String ch, int i, double size, TextStyle style) => AnimatedBuilder(
      animation: intro,
      builder: (_, __) {
        final v = Curves.easeOutCubic.transform(Interval(i * .06, i * .06 + .3).transform(intro.value));
        return Opacity(opacity: v, child: Transform.translate(offset: Offset(0, (1 - v) * size * .2), child: Text(ch, style: style)));
      });

  @override
  Widget build(BuildContext context) {
    final p = context.p, mob = context.mob;
    final top = p.ink.withOpacity(.55), bottom = p.ink.withOpacity(0);
    final size = mob ? context.w * .40 : 400.0;
    final padV = size * .3, padH = size * .08; // room so nothing leaves the mask, letters never get cut
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
            child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.diagonal3Values(1, K.heroWordStretch, 1), // taller than natural
                // One mask for the whole word, bigger than the letters, so no letter pokes out of it
                // (that is what left the white edges). The padding stays solid, the word itself fades to nothing.
                child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (r) {
                      final a = padV / r.height;
                      return LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [top, top, bottom, bottom], stops: [0, a, 1 - a, 1]).createShader(r);
                    },
                    child: Padding(padding: EdgeInsets.symmetric(vertical: padV, horizontal: padH), child: Column(mainAxisSize: MainAxisSize.min, children: lines))))));
  }
}