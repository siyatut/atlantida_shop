import 'package:flutter/material.dart';

import '../../../domain/product.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/product_image_box.dart';
import '../../../widgets/yellow_button.dart';

class CatalogProductTile extends StatelessWidget {
  const CatalogProductTile({
    super.key,
    required this.product,
    required this.onOpenDetails,
  });

  final Product product;
  final VoidCallback onOpenDetails;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return _Card(
      child: Row(
        children: [
          const SizedBox(width: 6),
          Expanded(child: _ProductImage(url: product.image)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: textTheme.titleMedium?.copyWith(
                    color: cs.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                _PriceText(price: product.price),
                const SizedBox(height: 12),
                YellowButton(
                  text: 'Подробнее',
                  onTap: onOpenDetails,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .20),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: child,
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    return ProductImageBox(imageUrl: url, borderRadius: 12);
  }
}

class _PriceText extends StatelessWidget {
  const _PriceText({this.price});
  final String? price;

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).textTheme.bodyMedium;
    final hasPrice = price != null && price!.isNotEmpty;

    return Text(
      hasPrice ? '$price руб.' : 'Цена по запросу',
      style: base?.copyWith(
        fontWeight: FontWeight.w700,
        color: hasPrice ? AppColors.deepBlue : AppColors.softInk,
      ),
    );
  }
}
