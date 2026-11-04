import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haadiya_portfolio/core/constants.dart';
import 'package:haadiya_portfolio/viewmodels/portfolio_vm.dart';
import 'package:haadiya_portfolio/widgets/project_card.dart';
import 'package:haadiya_portfolio/core/responsive.dart';
import 'package:haadiya_portfolio/widgets/reveal.dart';
import 'package:haadiya_portfolio/widgets/section_block.dart';

class WorkSection extends ConsumerWidget {
  const WorkSection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(portfolioProvider).projects;
    final inner = math.min(context.w, K.maxWidth) - context.pad * 2;
    final cardW = context.wide ? (inner - K.gap) / 2 : inner;
    return SectionBlock(1, K.navLinks[1], 'Products I have built and shipped.', Wrap(spacing: K.gap, runSpacing: K.gap, children: [
      for (var i = 0; i < projects.length; i++) Reveal(delay: (i % 2) * 140, child: ProjectCard(projects[i], cardW)),
    ]));
  }
}
