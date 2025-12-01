import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductImageBox extends StatelessWidget {
  const ProductImageBox({
    super.key,
    required this.imageUrl,
    this.borderRadius = 16,
    this.backgroundColor,
    this.fit = BoxFit.contain,
  });

  final String? imageUrl;
  final double borderRadius;
  final Color? backgroundColor;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = backgroundColor ?? cs.surface; 
    final iconColor = cs.onSurface.withValues(alpha: .25);

    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        clipBehavior: Clip.antiAlias,
        child: (imageUrl == null || imageUrl!.isEmpty)
            ? Icon(Icons.image_outlined, size: 48, color: iconColor)
            : CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: fit,
                placeholder: (_, __) => const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (_, __, ___) =>
                    Icon(Icons.broken_image_outlined, color: iconColor),
              ),
      ),
    );
  }
}
