import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../home_content.dart';
import 'home_surface_card.dart';

class HomeAdvantages extends StatelessWidget {
  const HomeAdvantages({super.key, required this.items});
  final List<HomeAdvantage> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final twoCols = constraints.maxWidth > 380;
        const gap = 12.0;
        final itemWidth =
            twoCols ? (constraints.maxWidth - gap) / 2 : constraints.maxWidth;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: items
              .map((e) => SizedBox(width: itemWidth, child: _AdvCard(adv: e)))
              .toList(),
        );
      },
    );
  }
}

class _AdvCard extends StatelessWidget {
  const _AdvCard({required this.adv});
  final HomeAdvantage adv;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: homeCardBg(context),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.white.withValues(alpha: .06),
            offset: const Offset(-2, -2),
            blurRadius: 6,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: .12),
            offset: const Offset(3, 3),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: cs.surface.withValues(alpha: .95),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .05),
                  blurRadius: 6,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Icon(adv.icon, color: AppColors.deepBlue, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(adv.title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(
                  adv.text,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: cs.onSurface.withValues(alpha: .75),
                        height: 1.3,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
