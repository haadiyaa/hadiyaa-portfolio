import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../core/responsive.dart';
import '../../viewmodels/portfolio_vm.dart';
import '../../widgets/auto_scroll_list.dart';
import '../../widgets/project_card.dart';
import '../../widgets/reveal.dart';
import '../../widgets/section_block.dart';

/// The projects drift sideways in a loop, edge to edge. Hover or touch to stop them.
class WorkSection extends ConsumerWidget {
  const WorkSection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(portfolioProvider).projects;
    final cardW = context.w < 500 ? context.w * .82 : K.workCardWidth;
    return SectionBlock(
        1,
        K.navLinks[1],
        'Products I have built and shipped.',
        // The row breaks out of the page padding to use the whole screen width.
        Reveal(
            child: OverflowBox(
                fit: OverflowBoxFit.deferToChild,
                minWidth: context.w,
                maxWidth: context.w,
                child: AutoScrollList(
                    count: projects.length,
                    itemExtent: cardW + K.gap,
                    height: context.cardH + 28, // room for the hover lift and glow
                    speed: K.workScrollSpeed,
                    itemBuilder: (_, i) => Padding(padding: const EdgeInsets.fromLTRB(0, 14, K.gap, 14), child: ProjectCard(projects[i], cardW))))));
  }
}