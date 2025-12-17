import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class AboutAccordionItem extends StatelessWidget {
  const AboutAccordionItem({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(bottom: 8),
        iconColor: AppColors.deepBlue,
        collapsedIconColor: AppColors.deepBlue,
        title: Text(
          title,
          style: textTheme.titleSmall?.copyWith(color: AppColors.deepBlue),
        ),
        children: [
          Text(
            text,
            style: textTheme.bodyMedium?.copyWith(
              color: cs.onSurface.withValues(alpha: .85),
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
