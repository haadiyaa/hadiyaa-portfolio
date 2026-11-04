import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:haadiya_portfolio/core/constants.dart';
import 'package:haadiya_portfolio/viewmodels/nav_vm.dart';
import 'package:haadiya_portfolio/viewmodels/portfolio_vm.dart';
import 'package:haadiya_portfolio/viewmodels/theme_vm.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // GlobalKey.currentContext needs the widgets binding

  group('ThemeViewModel', () {
    test('starts in dark mode and toggles both ways', () {
      final c = ProviderContainer();
      addTearDown(c.dispose);
      expect(c.read(themeProvider), ThemeMode.dark);
      c.read(themeProvider.notifier).toggle();
      expect(c.read(themeProvider), ThemeMode.light);
      c.read(themeProvider.notifier).toggle();
      expect(c.read(themeProvider), ThemeMode.dark);
    });
  });

  group('PortfolioViewModel', () {
    test('exposes the content from constants', () {
      final c = ProviderContainer();
      addTearDown(c.dispose);
      final vm = c.read(portfolioProvider);
      expect(vm.projects.length, K.projects.length);
      expect(vm.jobs.first.org, 'Screl Info');
      expect(vm.stats.map((s) => s.value), contains('5+'));
      expect(vm.stack, isNotEmpty);
    });

    test('lists Pantry Pal among the projects', () {
      final c = ProviderContainer();
      addTearDown(c.dispose);
      expect(c.read(portfolioProvider).projects.map((p) => p.name), contains('Pantry Pal'));
    });
  });

  group('NavViewModel', () {
    test('has one unique key per nav link', () {
      final vm = NavViewModel();
      expect(vm.keys.length, K.navLinks.length);
      expect(vm.keys.toSet().length, vm.keys.length);
    });

    test('go does not throw when a section is not on screen', () {
      expect(() => NavViewModel().go(0), returnsNormally);
    });
  });
}