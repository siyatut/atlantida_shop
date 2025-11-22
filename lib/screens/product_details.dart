import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../domain/product.dart';
import '../theme/app_colors.dart';

import '../utils/launcher_utils.dart';
import '../widgets/yellow_button.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final description = _cleanDescription(product.description);

    return Scaffold(
      appBar: AppBar(title: const SizedBox.shrink(), centerTitle: false),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                product.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.deepBlue,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
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
                        : CachedNetworkImage(
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
                  style: TextStyle(
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

    text = text.replaceAll(RegExp(r'<[^>]+>'), '');

    return text.trim();
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({required this.productTitle});

  final String productTitle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

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
          const Text(
            'Уточнить подробности в магазине',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
          ),
          const SizedBox(height: 8),
          Text(
            'Расскажите о вашем запросе, мы обязательно поможем сориентироваться',
            style: TextStyle(
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
