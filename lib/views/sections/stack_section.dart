import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../viewmodels/portfolio_vm.dart';
import '../../widgets/chips.dart';
import '../../widgets/reveal.dart';
import '../../widgets/section_block.dart';

class StackSection extends ConsumerWidget {
  const StackSection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(portfolioProvider).stack;
    return SectionBlock(2, K.navLinks[2], 'The tools I reach for.', Column(children: [
      for (var i = 0; i < groups.length; i++)
        Reveal(
            delay: i * 100,
            child: Padding(
            padding: const EdgeInsets.only(bottom: 28),
            child: context.mob
                ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [label(context, groups[i].label), chips(groups[i].items)])
                : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [label(context, groups[i].label), Expanded(child: chips(groups[i].items))]))),
    ]));
  }

  Widget label(BuildContext context, String text) =>
      SizedBox(width: 180, child: Padding(padding: const EdgeInsets.only(top: 8, bottom: 12), child: Text(text, style: TextStyle(color: context.p.muted))));

  Widget chips(List<String> items) => Wrap(spacing: 10, runSpacing: 10, children: [for (final s in items) SkillChip(s)]);
}