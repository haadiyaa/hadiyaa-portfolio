import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haadiya_portfolio/core/constants.dart';
import 'package:haadiya_portfolio/viewmodels/portfolio_vm.dart';
import 'package:haadiya_portfolio/widgets/reveal.dart';
import 'package:haadiya_portfolio/widgets/section_block.dart';
import 'package:haadiya_portfolio/widgets/timeline_item.dart';

class ExperienceSection extends ConsumerWidget {
  const ExperienceSection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobs = ref.watch(portfolioProvider).jobs;
    return SectionBlock(0, K.navLinks[0], 'Where I have been building.', Column(children: [
      for (var i = 0; i < jobs.length; i++) Reveal(delay: i * 120, child: TimelineItem(jobs[i], highlight: i == 0)),
    ]));
  }
}
