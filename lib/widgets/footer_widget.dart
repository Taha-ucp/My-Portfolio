import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: gray800))),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isRow = constraints.maxWidth > 768;
          final children = <Widget>[
            // Left: Logo
            ShaderMask(
              shaderCallback: (r) => const LinearGradient(
                colors: [primaryYellow, yellowDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(Rect.fromLTWH(0, 0, r.width, r.height)),
              blendMode: BlendMode.srcIn,
              child: Text('<Taha />', style: AppTextStyles.logo),
            ),
            // Center: Social (placeholder)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(padding: EdgeInsets.symmetric(horizontal: 6), child: Icon(Icons.code, color: gray400)),
                Padding(padding: EdgeInsets.symmetric(horizontal: 6), child: Icon(Icons.work, color: gray400)),
                Padding(padding: EdgeInsets.symmetric(horizontal: 6), child: Icon(Icons.message, color: gray400)),
              ],
            ),
            // Right: Copyright
            const Text('© 2026 Taha. Crafted with 💛', style: TextStyle(color: gray500)),
          ];

          if (isRow) {
            return Row(
              children: [
                Expanded(child: Align(alignment: Alignment.centerLeft, child: children[0])),
                Expanded(child: Center(child: children[1])),
                Expanded(child: Align(alignment: Alignment.centerRight, child: children[2])),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                children[0],
                const SizedBox(height: 12),
                children[1],
                const SizedBox(height: 12),
                children[2],
              ],
            );
          }
        },
      ),
    );
  }
}