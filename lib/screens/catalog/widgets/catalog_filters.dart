import 'package:flutter/material.dart';

import '../../../data/woo/woo_dto.dart';
import '../../../theme/app_colors.dart';

class CatalogFilters extends StatelessWidget {
  const CatalogFilters({
    super.key,
    required this.categories,
    required this.activeSlug,
    required this.onSelect,
  });

  final List<WooCategory> categories;
  final String? activeSlug;
  final ValueChanged<String?> onSelect;

  static const orderedTabs = [
    _TabInfo(slugs: ['rybki'], label: 'Рыбки'),
    _TabInfo(slugs: ['gryzuny'], label: 'Грызуны'),
    _TabInfo(slugs: ['koshki'], label: 'Кошки'),
    _TabInfo(slugs: ['sobaki'], label: 'Собаки'),
    _TabInfo(slugs: ['pticzy'], label: 'Птицы'),
    _TabInfo(slugs: ['reptilii'], label: 'Рептилии'),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    if (categories.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: LinearProgressIndicator(minHeight: 2),
      );
    }

    final chips = <Widget>[];

    for (final tab in orderedTabs) {
      final category = categories.cast<WooCategory?>().firstWhere((c) {
        if (c == null) return false;
        final slug = c.slug.toLowerCase();
        return tab.slugs.contains(slug);
      }, orElse: () => null);

      if (category == null) continue;

      final slug = category.slug.toLowerCase();
      final selected = activeSlug == slug;

      chips.add(
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ChoiceChip(
            selected: selected,
            showCheckmark: false,
            onSelected: (_) => onSelect(slug),
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selected) ...[
                  const Icon(Icons.check, size: 18, color: AppColors.white),
                  const SizedBox(width: 4),
                ],
                Text(tab.label),
              ],
            ),
            labelStyle: textTheme.labelLarge?.copyWith(
              color: selected ? AppColors.white : AppColors.deepBlue,
            ),
            selectedColor: AppColors.teal,
            backgroundColor: cs.surface.withValues(alpha: .95),
            side: BorderSide(
              color: selected ? AppColors.teal : Colors.transparent,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      scrollDirection: Axis.horizontal,
      child: Row(children: chips),
    );
  }
}

class _TabInfo {
  final List<String> slugs;
  final String label;
  const _TabInfo({required this.slugs, required this.label});
}
