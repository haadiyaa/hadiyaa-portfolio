import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:haadiya_portfolio/core/constants.dart';
import 'package:haadiya_portfolio/viewmodels/hero_vm.dart';
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

  group('parallax', () {
    const area = Size(1000, 800);
    test('is zero before the pointer has moved', () {
      expect(parallax(const Offset(-500, -500), area), Offset.zero);
    });

    test('is zero at the centre and +-1 at the edges', () {
      expect(parallax(const Offset(500, 400), area), Offset.zero);
      expect(parallax(const Offset(1000, 800), area), const Offset(1, 1));
      expect(parallax(const Offset(0, 0), area), const Offset(-1, -1));
    });

    test('is clamped when the pointer leaves the area', () {
      expect(parallax(const Offset(3000, 100), area).dx, 1);
    });
  });

  group('scroll progress', () {
    test('pinProgress goes from 0 to 1 and stays there', () {
      expect(pinProgress(0, 800), 0);
      expect(pinProgress(400, 800), .5);
      expect(pinProgress(2000, 800), 1);
      expect(pinProgress(100, 0), 0);
    });

    test('phase is 0 before, 1 after and eased in between', () {
      expect(phase(.1, .3, .6), 0);
      expect(phase(.9, .3, .6), 1);
      expect(phase(.45, .3, .6), allOf(greaterThan(0), lessThan(1)));
    });
  });

  test('marked splits highlighted parts', () {
    expect(marked('a *b* c'), [('a ', false), ('b', true), (' c', false)]);
    expect(marked('plain'), [('plain', false)]);
  });

  test('exitFade is 1 below the zone and 0 at the top of the screen', () {
    expect(exitFade(600, 250), 1);
    expect(exitFade(0, 250), 0);
    expect(exitFade(-100, 250), 0);
    expect(exitFade(125, 250), inExclusiveRange(0, 1));
  });
}