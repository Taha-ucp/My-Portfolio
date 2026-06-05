import 'package:flutter/material.dart';

class AppTextStyles {
  // Brand/logo
  static const TextStyle logo = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  // Hero title
  static const TextStyle heroTitle = TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.w800,
    height: 1.0,
    color: Colors.white,
  );

  // Section headings
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    height: 1.2,
  );

  // Subtitles
  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white70,
    height: 1.3,
  );

  // Body text
  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: Colors.white70,
    height: 1.5,
  );

  // Card titles (e.g., Services)
  static const TextStyle cardTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    height: 1.25,
  );

  // Small label text (e.g., Contact labels)
  static const TextStyle small = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white70,
    height: 1.2,
    letterSpacing: 0.2,
  );

  // Badge text (used by CustomBadge)
  static const TextStyle badge = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    height: 1.2,
    letterSpacing: 0.6,
  );
}