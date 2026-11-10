import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/theme.dart';
import 'hover.dart';

/// Quiet outlined tag used on cards, set in the mono face.
class TagChip extends StatelessWidget {
  final String label;
  const TagChip(this.label, {super.key});
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: context.p.line)),
      child: Text(label, style: mono(context, 12, context.p.soft)));
}

/// Larger chip for the stack section: a surface step and a clearer hairline on hover.
class SkillChip extends StatelessWidget {
  final String label;
  const SkillChip(this.label, {super.key});
  @override
  Widget build(BuildContext context) {
    final p = context.p;
    return Hover((h) => AnimatedContainer(
        duration: K.ms,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            color: h ? Color.alphaBlend(p.ink.withOpacity(.05), p.card) : p.card,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: h ? p.muted.withOpacity(.6) : p.line)),
        child: Text(label, style: TextStyle(fontWeight: FontWeight.w500, color: p.ink))));
  }
}