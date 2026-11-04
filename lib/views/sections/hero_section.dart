import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haadiya_portfolio/widgets/app_button.dart';
import 'package:haadiya_portfolio/core/constants.dart';
import 'package:haadiya_portfolio/viewmodels/nav_vm.dart';
import 'package:haadiya_portfolio/viewmodels/portfolio_vm.dart';
import 'package:haadiya_portfolio/core/responsive.dart';
import 'package:haadiya_portfolio/widgets/reveal.dart';
import 'package:haadiya_portfolio/core/theme.dart';
import 'package:provider/provider.dart' as pv;

class HeroSection extends ConsumerWidget {
  final Animation<double> intro;
  const HeroSection(this.intro, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.p, size = (context.w * .115).clamp(56.0, 148.0);
    final nav = pv.Provider.of<NavViewModel>(context, listen: false);
    const name = K.name;
    return ConstrainedBox(
        constraints: BoxConstraints(minHeight: context.h * .92),
        child: Padding(
            padding: const EdgeInsets.only(top: 110, bottom: 40),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Wrap(children: [
                for (var i = 0; i < name.length; i++)
                  name[i] == ' '
                      ? SizedBox(width: size * .3)
                      : AnimatedBuilder(
                          animation: intro,
                          builder: (_, __) {
                            final start = .05 + i * .045;
                            final v = Curves.easeOutCubic.transform(Interval(start, math.min(1, start + .4)).transform(intro.value));
                            return ClipRect(
                                child: Transform.translate(
                                    offset: Offset(0, (1 - v) * size * .9),
                                    child: Opacity(opacity: v, child: Text(name[i], style: head(context, size, i >= name.length - 2 ? p.accent : null)))));
                          }),
              ]),
              const SizedBox(height: 28),
              Seq(intro, .45, ConstrainedBox(constraints: const BoxConstraints(maxWidth: 560), child: Text(K.tagline, style: TextStyle(color: p.muted, fontSize: context.mob ? 17 : 20, height: 1.55)))),
              const SizedBox(height: 36),
              Seq(intro, .55, Wrap(spacing: 14, runSpacing: 14, children: [const AppButton('Email me', openMail), AppButton('See my work', () => nav.go(1), filled: false)])),
              const SizedBox(height: 64),
              Seq(intro, .65, Wrap(spacing: context.mob ? 36 : 64, runSpacing: 24, children: [
                for (final s in ref.watch(portfolioProvider).stats)
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(s.value, style: head(context, 40)),
                    const SizedBox(height: 6),
                    Text(s.label, style: TextStyle(color: p.muted)),
                  ])
              ])),
            ])));
  }
}
