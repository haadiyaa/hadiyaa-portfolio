import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:haadiya_portfolio/core/constants.dart';
import 'package:haadiya_portfolio/core/theme.dart';
import '../helpers.dart';

void main() {
  group('constants', () {
    test('links and email are valid', () {
      expect(K.email, contains('@'));
      expect(Uri.parse(K.linkedin).host, 'www.linkedin.com');
      expect(Uri.parse(K.github).host, 'github.com');
    });

    test('breakpoints are ordered', () {
      expect(K.mobileBp < K.wideBp, isTrue);
      expect(K.wideBp < K.tabletBp, isTrue);
      expect(K.tabletBp < K.maxWidth, isTrue);
    });

    test('every project has a name, description and tags', () {
      for (final p in K.projects) {
        expect(p.name, isNotEmpty);
        expect(p.desc, isNotEmpty);
        expect(p.tags, isNotEmpty);
      }
    });

    test('project names are unique', () {
      final names = K.projects.map((p) => p.name).toSet();
      expect(names.length, K.projects.length);
    });
  });

  group('theme', () {
    // AppTheme builds Google Fonts text themes. This runs as a widget test because the test clock
    // never completes the font downloads, so no font error can arrive. Do not wait on real time here.
    testWidgets('light and dark use their own palettes', (t) async {
      setupTest();
      expect(AppTheme.dark.brightness, Brightness.dark);
      expect(AppTheme.light.brightness, Brightness.light);
      expect(AppTheme.dark.scaffoldBackgroundColor, K.dark.bg);
      expect(AppTheme.light.scaffoldBackgroundColor, K.light.bg);
      expect(AppTheme.dark.extension<Palette>(), isNotNull);
      expect(AppTheme.light.extension<Palette>()!.accent, isNot(AppTheme.dark.extension<Palette>()!.accent));
    });
  });
}