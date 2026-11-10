import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/theme.dart';
import 'pressable.dart';

/// Filled buttons use the off-white of the palette with dark text, outlined ones a hairline.
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool filled;
  const AppButton(this.label, this.onTap, {super.key, this.filled = true});
  @override
  Widget build(BuildContext context) {
    final p = context.p;
    return Pressable(
        onTap: onTap,
        builder: (h, f) => AnimatedContainer(
            duration: K.ms,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            transform: Matrix4.translationValues(0, h ? -2 : 0, 0),
            decoration: BoxDecoration(
                color: filled ? (h ? p.soft : p.ink) : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: f ? p.accent : (filled ? Colors.transparent : (h ? p.muted : p.line)), width: f ? 2 : 1)),
            child: Text(label, style: TextStyle(fontWeight: FontWeight.w500, color: filled ? p.bg : p.ink))));
  }
}