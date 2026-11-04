import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haadiya_portfolio/core/constants.dart';
import 'package:haadiya_portfolio/views/home_screen.dart';
import 'package:haadiya_portfolio/core/theme.dart';
import 'package:haadiya_portfolio/viewmodels/theme_vm.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) => const ProviderScope(child: _Root());
}

class _Root extends ConsumerWidget {
  const _Root();
  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: K.siteTitle,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ref.watch(themeProvider),
        home: const HomeScreen(),
      );
}
