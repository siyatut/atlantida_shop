import 'package:flutter/material.dart';

import '../../../data/woo/woo_dto.dart';
import '../../../theme/app_colors.dart';

class CatalogSubcategories extends StatelessWidget {
  const CatalogSubcategories({
    super.key,
    required this.items,
    required this.activeId,
    required this.onSelect,
  });

  final List<WooCategory> items;
  final int? activeId;
  final ValueChanged<WooCategory> onSelect;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final sc = items[i];
          final selected = activeId == sc.id;

          return ChoiceChip(
            selected: selected,
            showCheckmark: false,
            onSelected: (_) => onSelect(sc),
            label: Text(sc.name),
            labelStyle: textTheme.labelLarge?.copyWith(
              color: selected ? AppColors.white : AppColors.deepBlue,
            ),
            selectedColor: AppColors.teal,
            backgroundColor: cs.surface.withValues(alpha: .95),
            side: BorderSide(
              color: selected ? AppColors.teal : Colors.transparent,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          );
        },
      ),
    );
  }
}
