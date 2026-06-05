import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/custom_badge.dart';
import '../components/custom_card.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  static const _maxWidth = 896.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomBadge(label: 'Get In Touch'),
              const SizedBox(height: 14),
              ShaderMask(
                shaderCallback: (r) => const LinearGradient(
                  colors: [Colors.white, gray300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(Rect.fromLTWH(0, 0, r.width, r.height)),
                blendMode: BlendMode.srcIn,
                child: Text(
                  "Let's Build Something Amazing",
                  style: AppTextStyles.sectionTitle,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Have a project in mind? I'm always open to discussing new opportunities and creative ideas.",
                style: AppTextStyles.body.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              LayoutBuilder(builder: (context, constraints) {
                final isRow = constraints.maxWidth >= 560;
                final children = [
                  _ContactCard(
                    icon: LucideIcons.mail,
                    label: 'Email',
                    value: 'tahasaqib552@gmail.com',
                    onTap: () => _openUrl('mailto:tahasaqib552@gmail.com'),
                  ),
                  _ContactCard(
                    icon: LucideIcons.phone,
                    label: 'Phone',
                    value: '+92 3234505820',
                    onTap: () => _openUrl('tel:+923234505820'),
                  ),
                ];

                return isRow
                    ? Row(
                        children: [
                          Expanded(child: children[0]),
                          const SizedBox(width: 16),
                          Expanded(child: children[1]),
                        ],
                      )
                    : Column(
                        children: [
                          children[0],
                          const SizedBox(height: 16),
                          children[1],
                        ],
                      );
              }).animate().fadeIn(duration: 400.ms).slideY(begin: 0.08, end: 0, duration: 400.ms),

              const SizedBox(height: 24),

              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 12,
                children: const [
                 // _SocialIcon(icon: LucideIcons.github, url: 'https://github.com/Taha-ucp'),
                  _SocialIcon(icon: LucideIcons.linkedin, url: 'https://www.linkedin.com/in/taha-saqib-821154334/'),
                 // _SocialIcon(icon: LucideIcons.twitter, url: 'https://twitter.com/your-handle'),
                ],
              ).animate(delay: 100.ms).fadeIn(duration: 400.ms).slideY(begin: 0.08, end: 0, duration: 400.ms),

              const SizedBox(height: 32),

            
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(
      uri,
      mode: LaunchMode.platformDefault,
      webOnlyWindowName: '_blank',
    );
  }
}

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _ContactCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.identity()..translate(0.0, _hovered ? -3.0 : 0.0),
            child: CustomCard(
              borderColor: _hovered ? primaryYellow.withOpacity(0.5) : null,
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: primaryYellow.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: primaryYellow.withOpacity(0.3)),
                    ),
                    child: Icon(widget.icon, color: primaryYellow, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.label, style: AppTextStyles.small.copyWith(color: gray300)),
                        const SizedBox(height: 4),
                        Text(
                          widget.value,
                          style: AppTextStyles.body.copyWith(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;

  const _SocialIcon({required this.icon, required this.url});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(
      uri,
      mode: LaunchMode.platformDefault,
      webOnlyWindowName: '_blank',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => _openUrl(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          transform: Matrix4.identity()
            ..scale(_hovered ? 1.1 : 1.0)
            ..rotateZ(_hovered ? 0.087 : 0),
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: yellowGradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: primaryYellow.withOpacity(0.25), blurRadius: 16, spreadRadius: 2),
            ],
          ),
          child: Icon(widget.icon, color: Colors.black, size: 28),
        ),
      ),
    );
  }
}