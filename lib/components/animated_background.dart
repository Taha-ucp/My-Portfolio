import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Soft radial glows (no solid circle fills), so edges aren't visible.
class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: const [
          // Left glow
          Positioned(left: -80, top: -40, child: _RadialGlow(size: 520)),
          // Center glow
          Positioned(left: 220, top: 140, child: _RadialGlow(size: 560, opacity: 0.09)),
          // Right glow
          Positioned(right: -120, bottom: -60, child: _RadialGlow(size: 680, opacity: 0.10)),
        ],
      ),
    );
  }
}

class _RadialGlow extends StatelessWidget {
  final double size;
  final double opacity;
  const _RadialGlow({required this.size, this.opacity = 0.12});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // Radial gradient fades smoothly to transparent: no visible “circle”
          gradient: RadialGradient(
            colors: [
              primaryYellow.withOpacity(opacity),
              primaryYellow.withOpacity(0.0),
            ],
            stops: const [0.0, 1.0],
          ),
        ),
      ),
    );
  }
}