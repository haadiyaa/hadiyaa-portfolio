import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/responsive.dart';
import '../core/theme.dart';

/// The name under the character: capitals with wide gaps between the letters.
class HeroName extends StatelessWidget {
  const HeroName({super.key});
  @override
  Widget build(BuildContext context) {
    final spacing = context.mob ? 8.0 : 18.0;
    return Padding(
        padding: EdgeInsets.only(left: spacing), // balances the gap Flutter adds after the last letter
        child: Text(K.name.toUpperCase(),
            style: head(context, context.mob ? 15 : 20, context.p.ink).copyWith(fontWeight: FontWeight.w600, letterSpacing: spacing, height: 1.2)));
  }
}