import 'package:flutter/material.dart';
import 'package:haadiya_portfolio/models/models.dart';
import 'theme.dart';

/// Every constant of the app lives here: copy, links, sizes, durations, palettes and content.
class K {
  static const name = 'Haadiya CT';
  static const siteTitle = 'Haadiya CT | Flutter developer';
  static const email = 'haadiyact@gmail.com';
  static const linkedin = 'https://www.linkedin.com/in/haadiya-ct-47775621b/';
  static const github = 'https://github.com/haadiyaa';
  static const tagline = 'I build Flutter apps that stay fast and usable offline, from restaurant ERPs to live analytics dashboards.';
  static const contactTitle = 'Let\'s build something\npeople enjoy using.';
  static const footer = 'Haadiya CT, Kozhikode, Kerala. Built with Flutter.';
  static const navLinks = ['Experience', 'Work', 'Stack'];

  static const ms = Duration(milliseconds: 300);
  static const revealMs = Duration(milliseconds: 800);
  static const introMs = Duration(milliseconds: 2200);
  static const loopMs = Duration(seconds: 14);
  static const scrollMs = Duration(milliseconds: 800);

  static const mobileBp = 700.0, wideBp = 900.0, tabletBp = 1100.0, maxWidth = 1280.0, gap = 24.0;

  static const dark = Palette(
      bg: Color(0xFF130F1C), card: Color(0xFF1C1628), ink: Color(0xFFF4EEFF), soft: Color(0xFFC9BEDD),
      muted: Color(0xFF9A8FB3), line: Color(0x1FFFFFFF), accent: Color(0xFFFF7A9C), onAccent: Color(0xFF1A0B12), glow: Color(0xFF7C5CFF));
  static const light = Palette(
      bg: Color(0xFFF7F4FC), card: Color(0xFFFFFFFF), ink: Color(0xFF1B1230), soft: Color(0xFF4A3F63),
      muted: Color(0xFF7A6F92), line: Color(0x1F1B1230), accent: Color(0xFFD81B60), onAccent: Color(0xFFFFFFFF), glow: Color(0xFFFFA8C5));

  static const stats = [Stat('3+', 'years shipping Flutter'), Stat('5+', 'apps built'), Stat('4', 'platforms, one codebase')];

  static const jobs = [
    Job('Flutter developer', 'Screl Info', 'Nov 2024 to Oct 2026', [
      'Shipped ERP modules across sales, inventory, CRM and finance in Flutter and Dart.',
      'Owned the web front end and WPF desktop app for SincA ERP in C# and .NET.',
      'Worked with backend teams to shape and tune the APIs the apps depend on.',
    ]),
    Job('Flutter developer intern', 'Self Stack', 'Sep 2023 to Nov 2024', [
      'Turned Figma designs into responsive screens wired to REST APIs.',
      'Worked with Provider, GetX and BLoC on real client features.',
    ]),
    Job('B.Sc. Computer Science', 'Providence Women\'s College, University of Calicut', '2020 to 2023'),
  ];

  static const projects = [
    Project('Isselo', 'Android, iOS, desktop', 'Restaurant management that keeps working without internet and syncs to the server on its own. Sales, CRM, HR and accounting in one app.', ['Flutter', 'Riverpod', 'SQLite', 'Clean Architecture']),
    Project('Pantry Pal', 'Offline-first mobile app', 'Cuts household food waste: scan barcodes or receipts, get expiry reminders and recipes that use what is about to expire. Backed by 340 tests and CI.', ['Flutter', 'Bloc', 'sqflite', 'ML Kit', 'go_router']),
    Project('SincA Reports', 'Flutter', 'A live window into the SincA ERP for administrators: business reports and analytics, always one tap away.', ['Flutter', 'REST APIs']),
    Project('SincA ERP', 'Web and Windows', 'Enterprise suite covering sales, stock, finance, HRM and procurement. I built the web front end and the WPF desktop client.', ['C#', '.NET', 'WPF', 'XAML']),
    Project('Hidhayah', 'Mobile', 'An Islamic companion app with prayer times, a sensor-driven Qibla compass and bilingual learning resources.', ['Flutter', 'Device sensors']),
  ];

  static const stack = [
    StackGroup('Flutter and Dart', ['Riverpod', 'BLoC', 'Provider', 'GetX', 'Hooks', 'Freezed', 'Clean Architecture']),
    StackGroup('Data', ['SQLite', 'Hive', 'Firebase', 'REST APIs']),
    StackGroup('Beyond Flutter', ['C#', '.NET', 'WPF', 'Figma', 'Git']),
  ];
}