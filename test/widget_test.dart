import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:haadiya_portfolio/main.dart';
import 'helpers.dart';

Future<void> pumpApp(WidgetTester t, double width, [double height = 1000]) async {
  setupTest();
  setScreen(t, width, height);
  await t.pumpWidget(const App());
  await t.pump(const Duration(seconds: 3)); // the background loops forever, so no pumpAndSettle
}

void main() {
  testWidgets('desktop shows the hero, nav links and stats', (t) async {
    await pumpApp(t, 1400);
    expect(find.text('Say hello'), findsOneWidget);
    expect(find.text('Email me'), findsOneWidget);
    expect(find.text('See my work'), findsOneWidget);
    expect(find.text('5+'), findsOneWidget);
    expect(find.text('Experience'), findsNWidgets(2)); // nav link and section title
    expect(t.takeException(), isNull);
  });

  testWidgets('tablet width has no overflow', (t) async {
    await pumpApp(t, 800);
    expect(t.takeException(), isNull);
  });

  testWidgets('mobile hides nav links and has no overflow', (t) async {
    await pumpApp(t, 390, 800);
    expect(find.text('Experience'), findsOneWidget); // section title only
    expect(t.takeException(), isNull);
  });

  testWidgets('theme button switches between dark and light', (t) async {
    await pumpApp(t, 1400);
    ThemeMode mode() => t.widget<MaterialApp>(find.byType(MaterialApp)).themeMode!;
    expect(mode(), ThemeMode.dark);
    await t.tap(find.byTooltip('Light mode'));
    await t.pump();
    await t.pump(const Duration(milliseconds: 600));
    expect(mode(), ThemeMode.light);
    expect(find.byTooltip('Dark mode'), findsOneWidget);
    expect(Theme.of(t.element(find.byType(Scaffold).first)).brightness, Brightness.light);
  });
}