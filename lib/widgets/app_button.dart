import 'package:flutter/material.dart';
import 'package:haadiya_portfolio/core/constants.dart';
import 'package:haadiya_portfolio/core/theme.dart';
import 'hover.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool filled;
  const AppButton(this.label, this.onTap, {super.key, this.filled = true});
  @override
  Widget build(BuildContext context) {
    final p = context.p;
    return Hover((h) => GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
            duration: K.ms,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            transform: Matrix4.translationValues(0, h ? -3 : 0, 0),
            decoration: BoxDecoration(
                color: filled ? (h ? p.ink : p.accent) : Colors.transparent,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: filled ? Colors.transparent : (h ? p.accent : p.line))),
            child: Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: filled ? (h ? p.bg : p.onAccent) : p.ink)))));
  }
}
