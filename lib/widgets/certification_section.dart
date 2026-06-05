import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CertificationSection extends StatelessWidget {
  const CertificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Single certificate: title + issuer + image only (no links/actions)
    const cert = Certification(
      title: 'AppDev Certificate',
      issuer: 'LUMS',
      imageAsset: 'assets/images/lums.jpeg', // ensure this exists and is declared in pubspec.yaml
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (rect) =>
                yellowGradient.createShader(Rect.fromLTWH(0, 0, rect.width, rect.height)),
            blendMode: BlendMode.srcIn,
            child: Text('Certification', style: AppTextStyles.sectionTitle),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(LucideIcons.badgeCheck, size: 16, color: primaryYellow),
              const SizedBox(width: 8),
              Text('Issued by ${cert.issuer}', style: AppTextStyles.small),
            ],
          ),
          const SizedBox(height: 24),

          // Certificate preview card (image only)
          _CertificateCard(cert: cert),
        ],
      ),
    );
  }
}

class Certification {
  final String title;
  final String issuer;
  final String imageAsset;
  const Certification({
    required this.title,
    required this.issuer,
    required this.imageAsset,
  });
}

class _CertificateCard extends StatelessWidget {
  final Certification cert;
  const _CertificateCard({required this.cert});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryYellow.withOpacity(0.25)),
        boxShadow: [
          BoxShadow(
            color: primaryYellow.withOpacity(0.08),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image only (kept aspect ratio to avoid overflow)
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(
              cert.imageAsset,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _ImagePlaceholder(title: cert.title, issuer: cert.issuer),
            ),
          ),
          // Caption
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(cert.title, style: AppTextStyles.cardTitle),
          ),
        ],
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  final String title;
  final String issuer;
  const _ImagePlaceholder({required this.title, required this.issuer});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(LucideIcons.image, color: Colors.white38, size: 20),
          const SizedBox(height: 8),
          Text('$title (Image not found)', style: AppTextStyles.small.copyWith(color: Colors.white54)),
          const SizedBox(height: 4),
          Text('Issued by $issuer', style: AppTextStyles.small.copyWith(color: Colors.white38)),
        ],
      ),
    );
  }
}