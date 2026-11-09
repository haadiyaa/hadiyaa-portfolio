import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// A horizontal list that drifts sideways forever and loops. It pauses while the mouse is over it
/// or a finger is on it, and it can be dragged by hand in both directions.
class AutoScrollList extends StatefulWidget {
  final int count;
  final double itemExtent, height, speed; // speed in px per second
  final IndexedWidgetBuilder itemBuilder; // index is already wrapped into 0..count-1
  const AutoScrollList({super.key, required this.count, required this.itemExtent, required this.height, required this.speed, required this.itemBuilder});
  @override
  State<AutoScrollList> createState() => _AutoScrollListState();
}

class _AutoScrollListState extends State<AutoScrollList> with SingleTickerProviderStateMixin {
  // Start far from 0 so the list can also be dragged backwards without hitting an edge.
  late final ScrollController ctrl = ScrollController(initialScrollOffset: widget.itemExtent * widget.count * 1000);
  late final Ticker ticker = createTicker(_tick)..start();
  Duration last = Duration.zero;
  bool hovered = false, touched = false;

  void _tick(Duration t) {
    final dt = ((t - last).inMicroseconds / 1e6).clamp(0.0, 1 / 20).toDouble();
    last = t;
    if (hovered || touched || !ctrl.hasClients || MediaQuery.of(context).disableAnimations) return;
    ctrl.jumpTo(ctrl.offset + widget.speed * dt);
  }

  @override
  void dispose() {
    ticker.dispose();
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
      onEnter: (_) => hovered = true,
      onExit: (_) => hovered = false,
      child: Listener(
          onPointerDown: (_) => touched = true,
          onPointerUp: (_) => touched = false,
          onPointerCancel: (_) => touched = false,
          child: SizedBox(
              height: widget.height,
              child: ListView.builder(
                  controller: ctrl,
                  scrollDirection: Axis.horizontal,
                  itemExtent: widget.itemExtent,
                  clipBehavior: Clip.none, // hover shadows and lifts are not cut off
                  itemBuilder: (c, i) => widget.itemBuilder(c, i % widget.count)))));
}