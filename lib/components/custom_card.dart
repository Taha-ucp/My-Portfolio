import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool enableHover;
  final Color? borderColor;

  const CustomCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius = 20,
    this.enableHover = true,
    this.borderColor,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.borderColor ??
        (_hovered ? primaryYellow.withOpacity(0.5) : gray700);

    return MouseRegion(
      onEnter: (_) => widget.enableHover ? setState(() => _hovered = true) : null,
      onExit: (_) => widget.enableHover ? setState(() => _hovered = false) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0)
          ..scale(_hovered ? 1.01 : 1.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gray800.withOpacity(0.5),
              gray900.withOpacity(0.5),
            ],
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(color: borderColor, width: 1),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: primaryYellow.withOpacity(0.1),
                    blurRadius: 18,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Padding(padding: widget.padding, child: widget.child),
      ),
    );
  }
}