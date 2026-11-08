import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as pv;
import '../core/responsive.dart';
import '../core/theme.dart';
import '../viewmodels/nav_vm.dart';
import 'reveal.dart';

/// Title, subtitle and spacing shared by every section; registers its scroll key.
class SectionBlock extends StatelessWidget {
  final int index;
  final String title, subtitle;
  final Widget child;
  const SectionBlock(this.index, this.title, this.subtitle, this.child, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
      key: pv.Provider.of<NavViewModel>(context, listen: false).keys[index],
      padding: EdgeInsets.only(top: context.mob ? 80 : 140),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Reveal(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: head(context, context.mob ? 38 : 60)),
          const SizedBox(height: 14),
          Text(subtitle, style: TextStyle(color: context.p.muted, fontSize: 17)),
        ])),
        const SizedBox(height: 44),
        child,
      ]));
}