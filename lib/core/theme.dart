import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haadiya_portfolio/core/constants.dart';

/// Colors that change between light and dark mode.
@immutable
class Palette extends ThemeExtension<Palette> {
  final Color bg, card, ink, soft, muted, line, accent, onAccent, glow;
  const Palette({required this.bg, required this.card, required this.ink, required this.soft, required this.muted,
      required this.line, required this.accent, required this.onAccent, required this.glow});
  @override
  Palette copyWith() => this;
  @override
  Palette lerp(ThemeExtension<Palette>? other, double t) => other is Palette && t >= .5 ? other : this;
}

class AppTheme {
  static ThemeData _build(Palette p, Brightness b) => ThemeData(
        brightness: b,
        scaffoldBackgroundColor: p.bg,
        extensions: [p],
        colorScheme: ColorScheme.fromSeed(seedColor: p.accent, brightness: b),
        textTheme: GoogleFonts.instrumentSansTextTheme(ThemeData(brightness: b).textTheme).apply(bodyColor: p.ink, displayColor: p.ink),
      );
  static final dark = _build(K.dark, Brightness.dark);
  static final light = _build(K.light, Brightness.light);
}

extension ThemeX on BuildContext {
  Palette get p => Theme.of(this).extension<Palette>()!;
}

TextStyle head(BuildContext c, double s, [Color? color]) => GoogleFonts.bricolageGrotesque(
    fontSize: s, fontWeight: FontWeight.w700, height: 1.05, letterSpacing: -s * .03, color: color ?? c.p.ink);