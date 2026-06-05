import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../components/custom_button.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/responsive.dart';

/// Desktop-first navigation bar.
class NavigationBarWidget extends StatelessWidget {
  final void Function(String sectionId) onNavigate;
  final String activeSection;

  const NavigationBarWidget({
    super.key,
    required this.onNavigate,
    required this.activeSection,
  });

  // Updated items
  static const sections = ['Home', 'Certification', 'Services', 'Projects', 'About'];

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;
    final barHeight = isDesktop ? 76.0 : 64.0;
    final sidePad = isDesktop ? 22.0 : 12.0;

    return Container(
      height: barHeight,
      margin: EdgeInsets.symmetric(horizontal: sidePad),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.72), // more prominent
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: primaryYellow.withOpacity(0.35), width: 1.5),
        boxShadow: [
          BoxShadow(color: primaryYellow.withOpacity(0.12), blurRadius: 24, spreadRadius: 2, offset: const Offset(0, 8)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sidePad),
                // Brand name in yellow
                child: Text('<Taha />', style: AppTextStyles.logo.copyWith(color: primaryYellow)),
              ),
              const Spacer(),
              if (isDesktop)
                Row(
                  children: sections
                      .map((s) => _NavItem(
                            label: s.toUpperCase(),
                            active: activeSection == s,
                            onTap: () => onNavigate(s),
                            height: barHeight,
                          ))
                      .toList(),
                ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sidePad),
                child: CustomButton(
                  label: 'Hire Me',
                  icon: const Icon(LucideIcons.rocket, color: Colors.black, size: 20),
                  onPressed: () => onNavigate('contact'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  final double height;

  const _NavItem({required this.label, required this.active, required this.onTap, required this.height});

  @override
  Widget build(BuildContext context) {
    final color = active ? primaryYellow : Colors.white;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: height,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color, letterSpacing: 0.8)),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: 3,
                width: active ? 22 : 0,
                decoration: BoxDecoration(color: primaryYellow, borderRadius: BorderRadius.circular(2)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}