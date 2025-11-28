import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../domain/product.dart';
import '../theme/app_colors.dart';

import '../utils/launcher_utils.dart';
import '../utils/text_utils.dart';
import '../widgets/yellow_button.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final description = fixPrepositions(_cleanDescription(product.description));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 72,
        title: Text(
          splitTitleInTwo(product.title),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: textTheme.titleLarge?.copyWith(
  fontWeight: FontWeight.w900,
  height: 1.15,
),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .18),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: (product.image == null || product.image!.isEmpty)
                        ? const Icon(
                            Icons.image_outlined,
                            size: 64,
                            color: Colors.black26,
                          )
                        : InteractiveViewer(
                            minScale: 1.0,
                            maxScale: 4.0,
                            child: CachedNetworkImage(
                              imageUrl: product.image!,
                              fit: BoxFit.contain,
                              placeholder: (_, __) => const Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                              errorWidget: (_, __, ___) => const Icon(
                                Icons.broken_image_outlined,
                                color: Colors.black26,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: cs.surface.withValues(alpha: .95),
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
                  description.isEmpty ? 'Описание появится позже' : description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: cs.onSurface.withValues(alpha: .9),
                    height: 1.3,
                  ),
                ),
              ),

              const SizedBox(height: 20),
              _ContactCard(productTitle: product.title),
            ],
          ),
        ),
      ),
    );
  }

  String _cleanDescription(String? html) {
    if (html == null) return '';
    var text = html;

    text = text
        .replaceAll('<br />', '\n')
        .replaceAll('<br/>', '\n')
        .replaceAll('<br>', '\n');

    text = text
        .replaceAll(RegExp(r'</p\s*>', caseSensitive: false), '\n\n')
        .replaceAll(RegExp(r'<p[^>]*>', caseSensitive: false), '');

    text = text
        .replaceAll(RegExp(r'<li[^>]*>', caseSensitive: false), '• ')
        .replaceAll(RegExp(r'</li\s*>', caseSensitive: false), '\n');

    text = text.replaceAll(
      RegExp(r'</?(ul|ol)[^>]*>', caseSensitive: false),
      '',
    );

    text = text.replaceAll(RegExp(r'<[^>]+>'), '');

    text = text
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'");

    text = text.replaceAll(RegExp(r'\n{3,}'), '\n\n');

    return text.trim();
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({required this.productTitle});

  final String productTitle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface.withValues(alpha: .95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .12),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Уточнить подробности в магазине', style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            'Расскажите о вашем запросе, мы обязательно поможем сориентироваться',
            style: textTheme.bodyMedium?.copyWith(
              color: cs.onSurface.withValues(alpha: .7),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: YellowButton(
                  text: 'Позвонить',
                  icon: Icons.call,
                  onTap: () => makePhoneCall('+79625046096'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: YellowButton(
                  text: 'Написать',
                  icon: Icons.email_outlined,
                  onTap: () => sendEmail(
                    email: 'gagin645@yandex.ru',
                    subject: 'Вопрос по товару из приложения',
                    body:
                        'Здравствуйте! Хочу уточнить наличие и стоимость товара «$productTitle».',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
