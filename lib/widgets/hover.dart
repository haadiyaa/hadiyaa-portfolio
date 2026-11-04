import 'package:flutter/material.dart';

/// Gives its builder a hover flag and a click cursor.
class Hover extends StatefulWidget {
  final Widget Function(bool hovered) builder;
  const Hover(this.builder, {super.key});
  @override
  State<Hover> createState() => _HoverState();
}

class _HoverState extends State<Hover> {
  bool h = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => h = true),
      onExit: (_) => setState(() => h = false),
      child: widget.builder(h));
}
