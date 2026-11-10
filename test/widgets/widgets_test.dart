import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:haadiya_portfolio/core/constants.dart';
import 'package:haadiya_portfolio/views/sections/work_section.dart';
import 'package:haadiya_portfolio/widgets/app_button.dart';
import 'package:haadiya_portfolio/widgets/chips.dart';
import 'package:haadiya_portfolio/widgets/project_card.dart';
import 'package:haadiya_portfolio/widgets/timeline_item.dart';
import '../helpers.dart';

void main() {
  testWidgets('AppButton calls onTap', (t) async {
    var taps = 0;
    await pumpPage(t, AppButton('Go', () => taps++));
    await t.tap(find.text('Go'));
    expect(taps, 1);
  });

  testWidgets('chips show their label', (t) async {
    await pumpPage(t, const Column(children: [TagChip('Flutter'), SkillChip('Riverpod')]));
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Riverpod'), findsOneWidget);
  });

  testWidgets('ProjectCard shows name, kind, description and tags', (t) async {
    setScreen(t, 1400);
    final p = K.projects[1];
    await pumpPage(t, ProjectCard(p, 500));
    expect(find.text(p.name), findsOneWidget);
    expect(find.text(p.kind), findsOneWidget);
    expect(find.text(p.desc), findsOneWidget);
    for (final tag in p.tags) {
      expect(find.text(tag), findsOneWidget);
    }
  });

  testWidgets('TimelineItem shows role, dates and points', (t) async {
    final job = K.jobs.first;
    await pumpPage(t, TimelineItem(job, highlight: true));
    expect(find.text(job.role), findsOneWidget);
    expect(find.text(job.when), findsOneWidget);
    expect(find.text(job.org), findsOneWidget);
    for (final point in job.points) {
      expect(find.text(point), findsOneWidget);
    }
  });

  for (final width in [1400.0, 800.0, 390.0]) {
    testWidgets('all work cards are the same size at ${width.toInt()}px', (t) async {
      setScreen(t, width);
      await pumpPage(t, const Padding(padding: EdgeInsets.symmetric(horizontal: 22), child: WorkSection()));
      final cards = find.byType(ProjectCard);
      expect(cards, findsWidgets); // the list is endless, so only the cards near the screen exist
      final first = t.getSize(cards.first);
      for (var i = 1; i < cards.evaluate().length; i++) {
        expect(t.getSize(cards.at(i)), first);
      }
      expect(t.takeException(), isNull);
    });
  }

  testWidgets('work cards drift sideways by themselves', (t) async {
    setScreen(t, 1400);
    await pumpPage(t, const WorkSection());
    double offset() => t.widget<ListView>(find.byType(ListView)).controller!.offset;
    final before = offset();
    for (var i = 0; i < 60; i++) {
      await t.pump(const Duration(milliseconds: 33)); // about 2 seconds in frame-sized steps
    }
    expect(offset(), greaterThan(before + 40)); // drifts about 40 px a second
  });
}