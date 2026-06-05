import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final services = const [
      _Service(icon: LucideIcons.code2, title: 'Web Apps', desc: 'Robust Flutter web apps with clean architecture and high performance.'),
      _Service(icon: LucideIcons.paintbrush, title: 'UI/UX', desc: 'Elegant, accessible interfaces with pixel-perfect design systems.'),
      _Service(icon: LucideIcons.smartphone, title: 'Mobile', desc: 'Cross‑platform apps with fast startup and smooth animations.'),
      _Service(icon: LucideIcons.server, title: 'Backend', desc: 'Secure Firebase integrations, auth, and data modeling.'),
      _Service(icon: LucideIcons.gauge, title: 'Perf Tuning', desc: 'Bundle slimming, lazy loading and layout stability.'),
      _Service(icon: LucideIcons.wrench, title: 'Maintenance', desc: 'CI/CD, error monitoring and long‑term support.'),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        // Desktop-first grid that never overflows vertically
        const gap = 20.0;
        int columns = 3;
        if (constraints.maxWidth < 1100) columns = 2;
        if (constraints.maxWidth < 760) columns = 1;

        final itemWidth = (constraints.maxWidth - gap * (columns - 1)) / columns;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Services', style: AppTextStyles.sectionTitle),
            const SizedBox(height: 16),
            Text('What I can do for you', style: AppTextStyles.subtitle),
            const SizedBox(height: 28),
            Wrap(
              spacing: gap,
              runSpacing: gap,
              children: services
                  .map((s) => _ServiceCard(
                        service: s,
                        width: itemWidth,
                      ))
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}

class _Service {
  final IconData icon;
  final String title;
  final String desc;
  const _Service({required this.icon, required this.title, required this.desc});
}

class _ServiceCard extends StatelessWidget {
  final _Service service;
  final double width;
  const _ServiceCard({required this.service, required this.width});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 160),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: primaryYellow.withOpacity(0.15)),
          boxShadow: [
            BoxShadow(color: primaryYellow.withOpacity(0.06), blurRadius: 16, spreadRadius: 1),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // let content dictate height, prevents overflows
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: yellowGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(service.icon, color: Colors.black, size: 22),
            ),
            const SizedBox(height: 12),
            Text(service.title, style: AppTextStyles.cardTitle),
            const SizedBox(height: 8),
            Text(service.desc, style: AppTextStyles.body.copyWith(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}