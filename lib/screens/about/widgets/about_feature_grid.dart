import 'package:flutter/material.dart';

import '../about_content.dart'; // <-- важно
import '../../../theme/app_colors.dart';
import '../../../utils/spacing.dart';
import '../../../utils/text_utils.dart';

class AboutFeatureGrid extends StatelessWidget {
  const AboutFeatureGrid({super.key, required this.items});
  final List<AboutFeatureData> items;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final twoCols = constraints.maxWidth > 380;
        const gap = 12.0;
        final itemWidth =
            twoCols ? (constraints.maxWidth - gap) / 2 : constraints.maxWidth;

        return Wrap(
          spacing: gap,
          runSpacing: 10,
          children: items.map((f) {
            return SizedBox(
              width: itemWidth,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(f.icon, color: AppColors.deepBlue, size: 20),
                  hGap(8),
                  Expanded(
                    child: Text(
                      fixPrepositions(f.text),
                      style: textTheme.bodyMedium?.copyWith(
                        color: cs.onSurface.withValues(alpha: .9),
                        height: 1.25,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
