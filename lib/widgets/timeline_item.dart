import 'package:flutter/material.dart';
import 'package:haadiya_portfolio/models/models.dart';
import 'package:haadiya_portfolio/core/responsive.dart';
import 'package:haadiya_portfolio/core/theme.dart';

class TimelineItem extends StatelessWidget {
  final Job job;
  final bool highlight;
  const TimelineItem(this.job, {super.key, this.highlight = false});
  @override
  Widget build(BuildContext context) {
    final p = context.p;
    return Container(
        margin: const EdgeInsets.only(left: 6),
        padding: const EdgeInsets.only(left: 32, bottom: 48),
        decoration: BoxDecoration(border: Border(left: BorderSide(color: p.line))),
        child: Stack(clipBehavior: Clip.none, children: [
          Positioned(
              left: -39, top: 6,
              child: Container(
                  width: 14, height: 14,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: highlight ? p.accent : p.bg,
                      border: Border.all(color: highlight ? p.accent : p.muted, width: 2),
                      boxShadow: highlight ? [BoxShadow(color: p.accent.withValues(alpha: .5), blurRadius: 14)] : []))),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(job.when, style: TextStyle(color: p.accent, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(job.role, style: head(context, context.mob ? 24 : 30)),
            const SizedBox(height: 4),
            Text(job.org, style: TextStyle(color: p.muted, fontSize: 16)),
            const SizedBox(height: 16),
            for (final t in job.points)
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 640), child: Text(t, style: TextStyle(color: p.soft, height: 1.55, fontSize: 16)))),
          ]),
        ]));
  }
}
