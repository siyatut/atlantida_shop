import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class CatalogLoadMoreFooter extends StatelessWidget {
  const CatalogLoadMoreFooter({
    super.key,
    required this.visible,
    required this.loading,
    required this.onTap,
  });

  final bool visible;
  final bool loading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    if (!visible) return const SizedBox.shrink();

    if (loading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.lightBlue,
            strokeWidth: 2.5,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: cs.surface.withValues(alpha: .95),
              foregroundColor: cs.onSurface,
              side: BorderSide(color: cs.onSurface.withValues(alpha: .25)),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: AppColors.deepBlue.withValues(alpha: .25),
                  width: 1.2,
                ),
              ),
              shadowColor: Colors.black.withValues(alpha: .20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.keyboard_double_arrow_down),
                const SizedBox(width: 6),
                Text('Показать ещё', style: textTheme.labelLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
