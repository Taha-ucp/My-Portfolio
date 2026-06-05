import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/custom_badge.dart';
import '../components/custom_button.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    this.linkedinUrl,
    this.onViewMyWork,
    this.onContact,
  });

  // New optional parameters
  final String? linkedinUrl;
  final VoidCallback? onViewMyWork;
  final VoidCallback? onContact;

  @override
  Widget build(BuildContext context) {
    const double titleSize = 72.0;
    const double subtitleSize = 22.0;
    const double bodySize = 16.0;
    const double sidePad = 48.0;

    final title = Wrap(
      spacing: 12,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        Text('Hey, I\'m', style: AppTextStyles.heroTitle.copyWith(fontSize: titleSize)),
        ShaderMask(
          shaderCallback: (b) =>
              yellowGradient.createShader(Rect.fromLTWH(0, 0, b.width, b.height)),
          blendMode: BlendMode.srcIn,
          child: Text('Taha', style: AppTextStyles.heroTitle.copyWith(fontSize: titleSize)),
        ),
      ],
    );

    final left = Padding(
      padding: const EdgeInsets.symmetric(horizontal: sidePad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomBadge(label: '👋 Welcome to my portfolio'),
          const SizedBox(height: 16),
          title,
          const SizedBox(height: 12),
          Text('Software Developer ',
              style: AppTextStyles.subtitle.copyWith(fontSize: subtitleSize)),
          const SizedBox(height: 10),
          Text(
            'I craft elegant code and beautiful designs. Turning ideas into powerful digital experiences.',
            style: AppTextStyles.body.copyWith(fontSize: bodySize),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(LucideIcons.mail, color: primaryYellow, size: 18),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'tahasaqib552@gmail.com',
                  style: AppTextStyles.body.copyWith(color: primaryYellow, fontSize: bodySize),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            children: [
             // const _SocialIcon(icon: LucideIcons.github, url: 'https://github.com/Taha-ucp'),
              _SocialIcon(
                icon: LucideIcons.linkedin,
                url: linkedinUrl ?? 'www.linkedin.com/in/taha-saqib-821154334',
              ),
              //const _SocialIcon(icon: LucideIcons.twitter, url: 'https://twitter.com/your-handle'),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              CustomButton(
                label: 'View My Work',
                variant: ButtonVariant.primary,
                icon: const Icon(LucideIcons.globe, color: Colors.black),
                onPressed: onViewMyWork,
              ),
              CustomButton(
                label: 'Get In Touch',
                variant: ButtonVariant.outline,
                icon: const Icon(LucideIcons.mail, color: primaryYellow),
                onPressed: onContact ?? () => _openUrl('mailto:tahasaqib552@gmail.com'),
              ),
            ],
          ),
        ],
      ),
    );

    final right = SizedBox(
      width: 380,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: primaryYellow.withOpacity(0.22), blurRadius: 90, spreadRadius: 26),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              width: 300,
              height: 360,
              child: Image.asset(
                'assets/images/portrait.png',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: Colors.black12),
              ),
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const double rightWidth = 380;
          const double gap = 24;
          final double minLeftWidth = 700;
          final bool twoColumns =
              constraints.maxWidth >= (rightWidth + gap + minLeftWidth);
          final double leftWidth =
              twoColumns ? constraints.maxWidth - rightWidth - gap : constraints.maxWidth;

          return Wrap(
            spacing: gap,
            runSpacing: 40,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(width: leftWidth, child: left),
              SizedBox(width: rightWidth, child: right),
            ],
          );
        },
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
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()
            ..scale(_hovered ? 1.08 : 1.0)
            ..rotateZ(_hovered ? 0.087 : 0),
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: yellowGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: primaryYellow.withOpacity(0.2), blurRadius: 12, spreadRadius: 1)],
          ),
          child: Icon(widget.icon, color: Colors.black, size: 24),
        ),
      ),
    );
  }
}