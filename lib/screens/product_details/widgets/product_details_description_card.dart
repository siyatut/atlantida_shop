import 'package:flutter/material.dart';

Color _cardBg(BuildContext context) =>
    Theme.of(context).colorScheme.surface.withValues(alpha: .95);

class ProductDetailsDescriptionCard extends StatelessWidget {
  const ProductDetailsDescriptionCard({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: _cardBg(context),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .10),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Text(
        text.isEmpty ? 'Описание появится позже' : text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: cs.onSurface.withValues(alpha: .9),
              height: 1.3,
            ),
      ),
    );
  }
}
