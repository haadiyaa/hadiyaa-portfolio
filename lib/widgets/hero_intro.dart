import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/responsive.dart';
import '../core/theme.dart';
import '../viewmodels/hero_vm.dart';

/// The short introduction. Each line fades and rises in at its own point of the scroll [progress].
class HeroIntro extends StatelessWidget {
  final double progress;
  const HeroIntro(this.progress, {super.key});
  @override
  Widget build(BuildContext context) {
    final pal = context.p,
        size = (context.w * .024).clamp(18.0, 34.0).toDouble();
    final base = head(context, size, pal.ink.withOpacity(.92)).copyWith(
        fontWeight: FontWeight.w500, height: 1.35, letterSpacing: -size * .01);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: context.pad),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          for (var i = 0; i < K.introLines.length; i++)
            Builder(builder: (_) {
              final t = phase(progress, .3 + i * .15, .55 + i * .15);
              return Opacity(
                  opacity: t,
                  child: Transform.translate(
                      offset: Offset(0, (1 - t) * 28),
                      child: Text.rich(
                          TextSpan(
                            style: TextStyle(fontSize: 30),
                            children: [
                              for (final (text, highlight)
                                  in marked(K.introLines[i]))
                                TextSpan(
                                    text: text,
                                    style: highlight
                                        ? TextStyle(
                                            color: pal.accent,
                                            fontWeight: FontWeight.w700)
                                        : null),
                            ],
                          ),
                          textAlign: TextAlign.center,
                          style: base)));
            }),
        ]));
  }
}
