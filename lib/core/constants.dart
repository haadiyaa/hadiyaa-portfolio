import 'package:flutter/material.dart';
import '../models/models.dart';
import 'theme.dart';

/// Every constant of the app lives here: copy, links, sizes, durations, palettes and content.
class K {
  static const name = 'Haadiya CT';
  static const siteTitle = 'Haadiya CT | Flutter developer';
  static const email = 'haadiyact@gmail.com';
  static const linkedin = 'https://www.linkedin.com/in/haadiya-ct-47775621b/';
  static const github = 'https://github.com/haadiyaa';
  static const contactTitle = 'Need a Flutter developer?\nGet in touch';
  static const footer = 'Haadiya CT, Kozhikode, Kerala. Built with Flutter';
  static const introLines = [
    "BUILDING *CROSS-PLATFORM* SCALABLE APPLICATIONS.",
    'FOCUSED ON CLEAN CODE, SEAMLESS INTEGRATIONS, AND INTUITIVE USER EXPERIENCES.',
  ]; // *text* is shown in the accent colour
  static const marqueeSpeed = 40.0; // px per second the work cards drift
  static const fadeZone = .25; // top share of the screen where content fades out as it scrolls away
  static const scrollHint = 'Scroll';
  static const heroLabel = 'FLUTTER'; // small spaced label above the big word
  static const heroWord = 'DEVELOPER';
  static const heroWordMobile = ['DEVEL', 'OPER']; // splits onto two lines on phones
  static const heroWordStretch = 1.7; // makes the background word taller than its natural proportions
  static const charShift = Offset(34, 18); // how far (px) the character slides towards the cursor
  static const charTilt = Offset(.2, .13); // how far (radians) she turns: x = left/right, y = up/down
  static const pinFactor = 1.0; // extra scroll, in screen heights, during which the hero stays pinned
  static const workCardWidth = 440.0; // width of a project card in the sliding row (phones use 82% of the screen)
  static const workScrollSpeed = 36.0; // px per second the project row drifts
  static const particleSample = 600; // width (px) the image is decoded at before it is turned into particles
  static const particleStep = 4; // one particle per this many sampled px: smaller = more, finer particles
  static const particleSize = 2.0; // size of each particle in screen px (independent of how many there are)
  static const particleFormSeconds = 2.0; // how long the image takes to form on load
  static const particleRepelRadius = .14; // cursor push radius, as a share of the image height
  static const particleRepelForce = 12000.0; // how hard the cursor pushes particles away
  static const characterAsset = 'assets/character/hero.webp';
  static const characterAspect = 0.854; // width / height of the cropped image
  static const navLinks = ['Experience', 'Works', 'Tech Stack'];

  static const ms = Duration(milliseconds: 300);
  static const revealMs = Duration(milliseconds: 800);
  static const introMs = Duration(milliseconds: 2200);
  static const loopMs = Duration(seconds: 14);
  static const scrollMs = Duration(milliseconds: 800);

  static const mobileBp = 700.0, wideBp = 900.0, tabletBp = 1100.0, maxWidth = 1280.0, gap = 24.0;

  // One neutral ramp tinted toward the navy of her blazer, warm off-white text from her hijab,
  // and a single muted sand accent taken from the same fabric. Used rarely.
  static const dark = Palette(
      bg: Color(0xFF0E1117), card: Color(0xFF151A22), ink: Color(0xFFECE9E2), soft: Color(0xFFB4B9C4),
      muted: Color(0xFF858B99), line: Color(0x1AECE9E2), accent: Color(0xFFD8C3A5), onAccent: Color(0xFF17130B), glow: Color(0xFF1B2436));
  static const light = Palette(
      bg: Color(0xFFF4F2EE), card: Color(0xFFFFFFFF), ink: Color(0xFF15181F), soft: Color(0xFF444A57),
      muted: Color(0xFF6B7180), line: Color(0x1A15181F), accent: Color(0xFF7E5F2B), onAccent: Color(0xFFFFFFFF), glow: Color(0xFFDDE2EC));

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
    Job('B.Sc. Computer Science',
        'Providence Women\'s College, University of Calicut', '2020 to 2023',[
        'Secured \'A\' Grade and is placed in the First Class Distinction.',
        '7.62 CGPA'
      ],),
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