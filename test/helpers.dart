import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haadiya_portfolio/core/theme.dart';
import 'package:haadiya_portfolio/viewmodels/nav_vm.dart';
import 'package:provider/provider.dart' as pv;

/// Fonts come from the network, which tests cannot reach, so font errors are ignored.
void setupTest() {
  GoogleFonts.config.allowRuntimeFetching = false;
  final old = FlutterError.onError;
  FlutterError.onError = (d) {
    if (d.exceptionAsString().toLowerCase().contains('font')) return;
    old?.call(d);
  };
}

void setScreen(WidgetTester t, double w, [double h = 1000]) {
  t.view.physicalSize = Size(w, h);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
}

/// Pumps [child] with the same providers and theme the real app has.
Future<void> pumpPage(WidgetTester t, Widget child, {ThemeData? theme}) async {
  setupTest();
  await t.pumpWidget(ProviderScope(
      child: pv.ChangeNotifierProvider(
          create: (_) => NavViewModel(),
          child: MaterialApp(theme: theme ?? AppTheme.dark, home: Scaffold(body: SingleChildScrollView(child: child))))));
  await t.pump(const Duration(seconds: 1));
}
