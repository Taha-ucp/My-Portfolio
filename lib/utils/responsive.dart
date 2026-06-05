import 'package:flutter/widgets.dart';

/// Desktop-first breakpoint helper.
class Breakpoints {
  static const double desktop = 1024;
  static const double tablet = 768;
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  bool get isDesktop => screenWidth >= Breakpoints.desktop;
  bool get isTablet => screenWidth >= Breakpoints.tablet && screenWidth < Breakpoints.desktop;
  bool get isMobile => screenWidth < Breakpoints.tablet;
}