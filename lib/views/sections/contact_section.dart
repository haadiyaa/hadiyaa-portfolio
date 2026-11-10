import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../viewmodels/nav_vm.dart';
import '../../widgets/app_button.dart';
import '../../widgets/pressable.dart';
import '../../widgets/reveal.dart';

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
          Pressable(
              onTap: openMail,
              builder: (h, f) => AnimatedDefaultTextStyle(
                  duration: K.ms,
                  style: head(context, context.mob ? 24 : 36, h || f ? p.accent : p.ink).copyWith(decoration: TextDecoration.underline, decorationColor: h || f ? p.accent : p.muted),
                  child: const Text(K.email))),
          const SizedBox(height: 32),
          Wrap(spacing: 16, runSpacing: 16, children: [
            AppButton('LinkedIn', () => openUrl(K.linkedin), filled: false),
            AppButton('GitHub', () => openUrl(K.github), filled: false),
          ]),
          const SizedBox(height: 80),
          Divider(color: p.line),
          Padding(padding: const EdgeInsets.symmetric(vertical: 24), child: Text(K.footer, style: TextStyle(color: p.muted))),
        ])));
  }
}