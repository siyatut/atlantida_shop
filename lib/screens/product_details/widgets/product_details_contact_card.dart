import 'package:flutter/material.dart';

import '../../../core/constants/app_contacts.dart';
import '../../../utils/launcher_utils.dart';
import '../../../utils/text_utils.dart';
import '../../../widgets/yellow_button.dart';

Color _cardBg(BuildContext context) =>
    Theme.of(context).colorScheme.surface.withValues(alpha: .95);

class ProductDetailsContactCard extends StatelessWidget {
  const ProductDetailsContactCard({super.key, required this.productTitle});

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
          Text(
            fixPrepositions('Уточнить подробности в магазине'),
            style: textTheme.titleMedium,
          ),
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
