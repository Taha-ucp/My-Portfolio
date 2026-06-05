import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum ButtonVariant { primary, outline }
enum ButtonSize { defaultSize, large }

class CustomButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final Widget? icon;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.defaultSize,
    this.icon,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _hovered = false;

  double get _height => widget.size == ButtonSize.large ? 56 : 40;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(14);

    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.icon != null) ...[
          widget.icon!,
          const SizedBox(width: 10),
        ],
        Text(
          widget.label,
          style: TextStyle(
            fontSize: widget.size == ButtonSize.large ? 18 : 16,
            fontWeight: FontWeight.w700,
            color: widget.variant == ButtonVariant.primary ? Colors.black : primaryYellow,
          ),
        ),
      ],
    );

    final decoration = widget.variant == ButtonVariant.primary
        ? BoxDecoration(
            gradient: LinearGradient(
              colors: _hovered ? [yellowDark, primaryYellow] : [primaryYellow, yellowDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: borderRadius,
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: primaryYellow.withOpacity(0.35),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          )
        : BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(color: primaryYellow.withOpacity(_hovered ? 0.7 : 0.4), width: 1.5),
            color: Colors.transparent,
          );

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Material(
        color: Colors.transparent, // Provide Material ancestor for InkWell
        borderRadius: borderRadius,
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: borderRadius,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            height: _height,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            transform: Matrix4.identity()..scale(_hovered ? 1.02 : 1.0),
            decoration: decoration,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}