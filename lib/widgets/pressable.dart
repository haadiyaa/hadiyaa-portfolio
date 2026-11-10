import 'package:flutter/material.dart';

/// A tappable area that also works with the keyboard: Tab to focus it, Enter or Space to press it.
/// The builder gets whether it is hovered and whether it has keyboard focus.
class Pressable extends StatefulWidget {
  final VoidCallback onTap;
  final Widget Function(bool hovered, bool focused) builder;
  const Pressable({super.key, required this.onTap, required this.builder});
  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool hovered = false, focused = false;
  @override
  Widget build(BuildContext context) => FocusableActionDetector(
      mouseCursor: SystemMouseCursors.click,
      onShowHoverHighlight: (v) => setState(() => hovered = v),
      onShowFocusHighlight: (v) => setState(() => focused = v),
      actions: {ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: (_) {
        widget.onTap();
        return null;
      })},
      child: GestureDetector(onTap: widget.onTap, child: widget.builder(hovered, focused)));
}