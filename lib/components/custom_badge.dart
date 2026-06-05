import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum BadgeVariant { filled, outline, subtle }

class CustomBadge extends StatelessWidget {
  final String label;
  final BadgeVariant variant;
  final bool uppercase;
  final EdgeInsets padding;
  final double radius;
  final IconData? leadingIcon;

  const CustomBadge({
    super.key,
    required this.label,
    this.variant = BadgeVariant.filled,
    this.uppercase = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.radius = 8,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final textValue = uppercase ? label.toUpperCase() : label;

    // Background and border per variant
    Color? bg;
    BoxBorder? border;
    switch (variant) {
      case BadgeVariant.filled:
        bg = primaryYellow.withOpacity(0.20);
        border = Border.all(color: primaryYellow.withOpacity(0.35));
        break;
      case BadgeVariant.outline:
        bg = Colors.white.withOpacity(0.03);
        border = Border.all(color: primaryYellow.withOpacity(0.35));
        break;
      case BadgeVariant.subtle:
        bg = Colors.white.withOpacity(0.06);
        border = Border.all(color: Colors.white.withOpacity(0.10));
        break;
    }

    // Text color: filled badge uses dark text for contrast
    final textStyle = (variant == BadgeVariant.filled)
        ? AppTextStyles.badge.copyWith(color: Colors.black)
        : AppTextStyles.badge.copyWith(color: Colors.white);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(radius),
        border: border,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[
            Icon(leadingIcon, size: 14, color: textStyle.color),
            const SizedBox(width: 6),
          ],
          Text(textValue, style: textStyle),
        ],
      ),
    );
  }
}