import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/responsive.dart';
import '../core/theme.dart';
import '../models/models.dart';
import 'chips.dart';
import 'hover.dart';

/// The one card used for every project.
class ProjectCard extends StatelessWidget {
  final Project project;
  final double width;
  final double? height; // defaults to the height for the current screen width
  const ProjectCard(this.project, this.width, {super.key, this.height});
  @override
  Widget build(BuildContext context) {
    final p = context.p;
    return SizedBox(
        width: width,
        child: Hover((h) => AnimatedContainer(
            duration: K.ms,
            curve: Curves.easeOut,
            transform: Matrix4.translationValues(0, h ? -4 : 0, 0),
            height: height ?? context.cardH,
            padding: EdgeInsets.all(context.mob ? 24 : 32),
            decoration: BoxDecoration(
                // Hover is a small surface step and a clearer hairline. No glow.
                color: h ? Color.alphaBlend(p.ink.withOpacity(.03), p.card) : p.card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: h ? p.muted.withOpacity(.5) : p.line)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(project.kind, style: mono(context, 13)),
                AnimatedRotation(turns: h ? -.125 : 0, duration: K.ms, child: Icon(Icons.arrow_forward, size: 20, color: h ? p.accent : p.muted)),
              ]),
              const SizedBox(height: 44),
              Text(project.name, style: head(context, 32)),
              const SizedBox(height: 12),
              Text(project.desc, style: TextStyle(color: p.muted, height: 1.6, fontSize: 16)),
              const Spacer(),
              Wrap(spacing: 8, runSpacing: 8, children: [for (final t in project.tags) TagChip(t)]),
            ]))));
  }
}