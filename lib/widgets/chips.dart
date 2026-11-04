import 'package:flutter/material.dart';
import 'package:haadiya_portfolio/core/constants.dart';
import 'package:haadiya_portfolio/core/theme.dart';
import 'hover.dart';

/// Quiet outlined tag used on cards.
class TagChip extends StatelessWidget {
  final String label;
  const TagChip(this.label, {super.key});
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: context.p.line)),
      child: Text(label, style: TextStyle(fontSize: 13, color: context.p.soft)));
}

/// Larger chip that lights up on hover, used in the stack section.
class SkillChip extends StatelessWidget {
  final String label;
  const SkillChip(this.label, {super.key});
  @override
  Widget build(BuildContext context) {
    final p = context.p;
    return Hover((h) => AnimatedContainer(
        duration: K.ms,
        transform: Matrix4.translationValues(0, h ? -3 : 0, 0),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(color: h ? p.accent : p.card, borderRadius: BorderRadius.circular(40), border: Border.all(color: h ? p.accent : p.line)),
        child: Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: h ? p.onAccent : p.ink))));
  }
}
