// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';

/// Responsive helpers and breakpoints for the app.
///
/// Default breakpoints:
/// - MOBILE_MAX: width < 600 -> treat as mobile
/// - DESKTOP_MIN: width >= 600 -> treat as desktop
///
/// Change the constants below to adjust breakpoints app-wide.
/// These helpers are intentionally small and dependency-free so they
/// can be used across the app (widgets, tests, etc.).
const double MOBILE_MAX = 600.0; // width < 600 -> mobile
const double DESKTOP_MIN = 600.0; // width >= 600 -> desktop

/// Returns true when the current [MediaQuery] width is in the mobile range.
bool isMobile(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return width < MOBILE_MAX;
}

/// Returns true when the current [MediaQuery] width is in the desktop range.
bool isDesktop(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return width >= DESKTOP_MIN;
}

/// A small helper widget that selects between two builders based on width.
/// Useful for concise responsive branches in tests and widgets.
class ResponsiveLayout extends StatelessWidget {
  final WidgetBuilder mobileBuilder;
  final WidgetBuilder desktopBuilder;

  const ResponsiveLayout({
    Key? key,
    required this.mobileBuilder,
    required this.desktopBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < MOBILE_MAX) {
      return mobileBuilder(context);
    }
    return desktopBuilder(context);
  }
}
