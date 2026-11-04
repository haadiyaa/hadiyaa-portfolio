import 'package:flutter/material.dart';
import 'package:haadiya_portfolio/widgets/app_button.dart';
import 'package:haadiya_portfolio/core/constants.dart';
import 'package:haadiya_portfolio/widgets/hover.dart';
import 'package:haadiya_portfolio/viewmodels/nav_vm.dart';
import 'package:haadiya_portfolio/core/responsive.dart';
import 'package:haadiya_portfolio/widgets/reveal.dart';
import 'package:haadiya_portfolio/core/theme.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});
  @override
  Widget build(BuildContext context) {
    final p = context.p;
    return Padding(
        padding: EdgeInsets.only(top: context.mob ? 90 : 160, bottom: 40),
        child: Reveal(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(K.contactTitle, style: head(context, context.mob ? 40 : 84)),
          const SizedBox(height: 36),
          Hover((h) => GestureDetector(
              onTap: openMail,
              child: AnimatedDefaultTextStyle(
                  duration: K.ms,
                  style: head(context, context.mob ? 22 : 36, h ? p.accent : p.ink).copyWith(decoration: TextDecoration.underline, decorationColor: h ? p.accent : p.muted),
                  child: const Text(K.email)))),
          const SizedBox(height: 32),
          Wrap(spacing: 14, runSpacing: 14, children: [
            AppButton('LinkedIn', () => openUrl(K.linkedin), filled: false),
            AppButton('GitHub', () => openUrl(K.github), filled: false),
          ]),
          const SizedBox(height: 80),
          Divider(color: p.line),
          Padding(padding: const EdgeInsets.symmetric(vertical: 20), child: Text(K.footer, style: TextStyle(color: p.muted))),
        ])));
  }
}
