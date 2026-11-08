import 'package:flutter/material.dart';
import '../core/theme.dart';

/// Small outlined capsule that tells people to scroll. Plain text: regular weight, normal letter spacing.
class ScrollHint extends StatelessWidget {
  final String text;
  const ScrollHint(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    final p = context.p;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: p.muted.withOpacity(.5))),
        child: Text(text,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0,
                color: p.soft)));
  }
}
