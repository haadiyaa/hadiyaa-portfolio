import 'package:flutter/material.dart';
import 'constants.dart';

extension Responsive on BuildContext {
  double get w => MediaQuery.sizeOf(this).width;
  double get h => MediaQuery.sizeOf(this).height;
  double get pin => h * K.pinFactor; // scroll distance the hero stays pinned for
  bool get mob => w < K.mobileBp;
  bool get wide => w >= K.wideBp;
  double get pad => w < K.mobileBp ? 22 : (w < K.tabletBp ? 44 : 80);
  /// One fixed height for every project card. Two narrow columns (900 to 1100px) need the most room.
  double get cardH => w < 500 ? 520 : (w < K.wideBp ? 400 : (w < K.tabletBp ? 470 : 430));
}