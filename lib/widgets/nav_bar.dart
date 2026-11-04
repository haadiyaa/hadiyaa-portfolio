import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as pv;
import '../core/constants.dart';
import '../core/responsive.dart';
import '../core/theme.dart';
import '../viewmodels/nav_vm.dart';
import '../viewmodels/theme_vm.dart';
import 'app_button.dart';
import 'hover.dart';

class NavBar extends ConsumerWidget {
  const NavBar({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.p, nav = pv.Provider.of<NavViewModel>(context, listen: false);
    final dark = ref.watch(themeProvider) == ThemeMode.dark;
    return ClipRect(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
                color: p.bg.withValues(alpha: .6),
                padding: EdgeInsets.symmetric(horizontal: context.pad, vertical: 12),
                child: Row(children: [
                  Expanded(child: Align(alignment: Alignment.centerLeft, child: Text(K.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: head(context, 20)))),
                  if (context.wide)
                    for (var i = 0; i < K.navLinks.length; i++)
                      Hover((h) => GestureDetector(
                          onTap: () => nav.go(i),
                          child: Padding(
                              padding: const EdgeInsets.only(right: 32),
                              child: AnimatedDefaultTextStyle(
                                  duration: K.ms,
                                  style: TextStyle(color: h ? p.accent : p.muted, fontWeight: FontWeight.w500),
                                  child: Text(K.navLinks[i]))))),
                  IconButton(
                      tooltip: dark ? 'Light mode' : 'Dark mode',
                      onPressed: ref.read(themeProvider.notifier).toggle,
                      icon: AnimatedSwitcher(duration: K.ms, child: Icon(dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined, key: ValueKey(dark), color: p.ink))),
                  const SizedBox(width: 8),
                  const AppButton('Say hello', openMail),
                ]))));
  }
}