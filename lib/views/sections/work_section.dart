import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../viewmodels/portfolio_vm.dart';
import '../../widgets/project_marquee.dart';
import '../../widgets/reveal.dart';
import '../../widgets/section_block.dart';

class WorkSection extends ConsumerWidget {
  const WorkSection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(portfolioProvider).projects;
    return SectionBlock(1, K.navLinks[1], 'Products I have built and shipped.', Reveal(child: ProjectMarquee(projects)));
  }
}