import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../domain/product.dart';
import '../utils/launcher_utils.dart';
import '../utils/text_utils.dart';
import '../widgets/yellow_button.dart';
import '../widgets/product_image_box.dart';
import '../core/app_contacts.dart';

Color _cardBg(BuildContext context) =>
    Theme.of(context).colorScheme.surface.withValues(alpha: .95);

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                  color: isDark ? _cardBg(context) : AppColors.white,
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
                child: ProductImageBox(imageUrl: product.image),
              ),
              const SizedBox(height: 24),
              Container(
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
    if (html == null || html.isEmpty) return '';

    var text = html;

    // Простые замены br → перенос строки
    text = text
        .replaceAll('<br />', '\n')
        .replaceAll('<br/>', '\n')
        .replaceAll('<br>', '\n');

    final buffer = StringBuffer();
    var i = 0;
    var consecutiveNewlines = 0;

    void writeWithNewlineCollapse(String s) {
      for (final codeUnit in s.codeUnits) {
        final ch = String.fromCharCode(codeUnit);
        if (ch == '\n') {
          if (consecutiveNewlines < 2) {
            buffer.write(ch);
          }
          consecutiveNewlines++;
        } else {
          consecutiveNewlines = 0;
          buffer.write(ch);
        }
      }
    }

    while (i < text.length) {
      final ch = text[i];

      if (ch == '<') {
        final close = text.indexOf('>', i + 1);
        if (close == -1) {
          // странный HTML, просто дописываем остаток
          writeWithNewlineCollapse(text.substring(i));
          break;
        }

        final rawTag = text.substring(i + 1, close).trim();
        final tag = rawTag.toLowerCase();

        if (tag.startsWith('/p')) {
          writeWithNewlineCollapse('\n\n');
        } else if (tag.startsWith('p')) {
          // <p ...> — ничего не пишем, просто разделитель
        } else if (tag.startsWith('li')) {
          writeWithNewlineCollapse('• ');
        } else if (tag.startsWith('/li')) {
          writeWithNewlineCollapse('\n');
        } else if (tag.startsWith('ul') ||
            tag.startsWith('/ul') ||
            tag.startsWith('ol') ||
            tag.startsWith('/ol')) {
          // list-теги игнорируем
        } else {
          // остальные теги просто срезаем
        }

        i = close + 1;
      } else {
        final nextTag = text.indexOf('<', i);
        final end = nextTag == -1 ? text.length : nextTag;
        writeWithNewlineCollapse(text.substring(i, end));
        i = end;
      }
    }

    var result = buffer.toString();

    // HTML-сущности
    result = result
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'");

    return result.trim();
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
        color: _cardBg(context),
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
                  onTap: () => makePhoneCall(AppContacts.phone),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: YellowButton(
                  text: 'Написать',
                  icon: Icons.email_outlined,
                  onTap: () => sendEmail(
                    email: AppContacts.email,
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
