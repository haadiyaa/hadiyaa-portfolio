import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:haadiya_portfolio/main.dart';
import 'package:haadiya_portfolio/widgets/hero_word.dart';
import 'helpers.dart';

Future<void> pumpApp(WidgetTester t, double width, [double height = 1000]) async {
  setupTest();
  setScreen(t, width, height);
  await t.pumpWidget(const App());
  await t.pump(const Duration(seconds: 3)); // the background loops forever, so no pumpAndSettle
}

Finder inWord(String letter) => find.descendant(of: find.byType(HeroWord), matching: find.text(letter));

void main() {
  testWidgets('desktop shows the word, the character and the name', (t) async {
    await pumpApp(t, 1400);
    expect(find.byType(HeroWord), findsOneWidget);
    expect(inWord('F'), findsOneWidget);
    expect(inWord('T'), findsNWidgets(2)); // FLUTTER has two Ts
    expect(inWord('R'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget); // floating character
    expect(find.text('HAADIYA CT'), findsOneWidget); // name in capitals under her
    expect(find.text('Experience'), findsOneWidget); // section title; the navbar is switched off
    expect(t.takeException(), isNull);
  });

  testWidgets('tablet width has no overflow', (t) async {
    await pumpApp(t, 800);
    expect(t.takeException(), isNull);
  });

  testWidgets('mobile splits the word over two lines and has no overflow', (t) async {
    await pumpApp(t, 390, 800);
    expect(find.descendant(of: find.byType(HeroWord), matching: find.byType(Row)), findsNWidgets(2)); // FLUT and TER
    expect(inWord('F'), findsOneWidget);
    expect(inWord('R'), findsOneWidget);
    expect(find.text('HAADIYA CT'), findsOneWidget);
    expect(t.takeException(), isNull);
  });

  testWidgets('theme button switches between dark and light', (t) async {
    await pumpApp(t, 1400);
    await t.tap(find.byTooltip('Light mode'));
    await t.pump(const Duration(milliseconds: 600));
    expect(Theme.of(t.element(find.byType(Scaffold).first)).brightness, Brightness.light);
  }, skip: true); // the navbar holds the theme button and is switched off for now
}