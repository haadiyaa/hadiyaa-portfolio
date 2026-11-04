import 'package:flutter/material.dart';
import 'package:haadiya_portfolio/core/constants.dart';
import 'package:url_launcher/url_launcher.dart';

void openUrl(String url) => launchUrl(Uri.parse(url));
void openMail() => openUrl('mailto:${K.email}');

/// Small UI state shared through Provider: section keys and scrolling.
class NavViewModel extends ChangeNotifier {
  final keys = List.generate(K.navLinks.length, (_) => GlobalKey());
  void go(int i) {
    final c = keys[i].currentContext;
    if (c != null) Scrollable.ensureVisible(c, duration: K.scrollMs, curve: Curves.easeInOutCubic);
  }
}
