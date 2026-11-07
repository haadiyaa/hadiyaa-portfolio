import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/constants.dart';

/// The character image with a slow bob and a soft shadow that shrinks as she rises.
class FloatingCharacter extends StatelessWidget {
  final Animation<double> loop;
  final double height;
  const FloatingCharacter(this.loop, this.height, {super.key});
  @override
  Widget build(BuildContext context) {
    final width = height * K.characterAspect;
    final shadow = Theme.of(context).brightness == Brightness.dark ? .5 : .22;
    return AnimatedBuilder(
        animation: loop,
        builder: (_, __) {
          final bob = math.sin(loop.value * 2 * math.pi * 4); // four bobs per loop, about 3.5s each
          return Column(mainAxisSize: MainAxisSize.min, children: [
            Transform.translate(
                offset: Offset(0, bob * 10),
                child: Image.asset(K.characterAsset,
                    width: width, height: height, fit: BoxFit.contain, filterQuality: FilterQuality.high,
                    errorBuilder: (_, __, ___) => SizedBox(width: width, height: height))),
            const SizedBox(height: 16),
            Container(
                width: width * .55 * (1 - .06 * bob),
                height: 18,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(shadow), blurRadius: 30, spreadRadius: 4)])),
          ]);
        });
  }
}