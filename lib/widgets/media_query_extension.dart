import 'package:flutter/material.dart';

extension MediaQueryExtension on MediaQueryData {
  bool get useMobileLayout {
    var shortestSide = size.shortestSide;

// Determine if we should use mobile layout or not, 600 here is
// a common breakpoint for a typical 7-inch tablet.
    return shortestSide < 600;
  }
}
