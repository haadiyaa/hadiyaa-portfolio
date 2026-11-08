import 'package:flutter/material.dart';
import '../core/responsive.dart';
import '../core/theme.dart';

/// Small capitals with wide gaps between the letters. Used for the name and the label above the word.
class HeroName extends StatelessWidget {
  final String text;
  const HeroName(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    final spacing = context.mob ? 8.0 : 18.0;
    return Padding(
        padding: EdgeInsets.only(left: spacing), // balances the gap Flutter adds after the last letter
        child: Text(text,
            style: head(context, context.mob ? 15 : 20, context.p.ink).copyWith(fontWeight: FontWeight.w600, letterSpacing: spacing, height: 1.2)));
  }
}