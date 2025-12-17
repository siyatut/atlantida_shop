import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../home_content.dart';

class HomeFeatureGrid extends StatelessWidget {
  const HomeFeatureGrid({super.key, required this.items});
  final List<HomeFeature> items;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

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
                  Icon(f.icon, color: AppColors.deepBlue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      f.text,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
