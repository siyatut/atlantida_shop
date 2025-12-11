import 'package:flutter/material.dart';

import '../core/app_contacts.dart';
import '../theme/app_colors.dart';
import '../widgets/yellow_button.dart';
import '../utils/launcher_utils.dart';
import '../utils/spacing.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  static const _phones = <_ContactItem>[
    _ContactItem(
      title: 'Магазин',
      phone: '+7 (962) 504-60-96',
      tel: '+79625046096',
    ),
    _ContactItem(
      title: 'Людмила',
      phone: '+7 (903) 059-59-92',
      tel: '+79030595992',
    ),
    _ContactItem(
      title: 'Александр',
      phone: '+7 (906) 351-17-06',
      tel: '+79063511706',
    ),
  ];

  static const _telegramUrl = 'https://t.me/gagin645';

  static const _addressTitle = 'Нижний Новгород, Коминтерна, 117';
  static const _addressSubtitle =
      'Универмаг «Сормовские Зори», 1 этаж,\nлевое крыло — за аптекой.';

  // Ссылки для открытия маршрута
  static const _yandexRouteUrl =
      'https://yandex.ru/maps/?pt=43.868429,56.350553&z=17&l=map';
  static const _googleRouteUrl =
      'https://www.google.com/maps/search/?api=1&query=56.350282512393726, 43.86842794102657';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Блок "Позвонить"
                  _SurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Позвонить',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        gap8,
                        for (int i = 0; i < _phones.length; i++) ...[
                          _PhoneRow(
                            label: _phones[i].phone,
                            subtitle: _phones[i].title,
                            onTap: () => makePhoneCall(_phones[i].tel),
                          ),
                          if (i != _phones.length - 1) gap8,
                        ],
                      ],
                    ),
                  ),

                  gap12,

                  // Блок "Написать"
                  _SurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Написать',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        gap12,
                        Row(
                          children: [
                            Expanded(
                              child: YellowButton(
                                text: 'Telegram',
                                icon: Icons.send_rounded,
                                onTap: () => openUrl(_telegramUrl),
                              ),
                            ),
                            hGap(12),
                            Expanded(
                              child: YellowButton(
                                text: 'Email',
                                icon: Icons.email_outlined,
                                onTap: () => sendEmail(
                                  email: AppContacts.email,
                                  subject: 'Вопрос из приложения',
                                  body: 'Здравствуйте! Хочу уточнить детали…',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  gap12,

                  // Блок "Адрес нашего магазина"
                  _SurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Адрес нашего магазина',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        gap8,
                        Text(
                          _addressTitle,
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: cs.onSurface,
                          ),
                        ),
                        gap6,
                        Text(
                          _addressSubtitle,
                          style: textTheme.bodyMedium?.copyWith(
                            color: cs.onSurface.withValues(alpha: .8),
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),

                  gap12,

                  // Новый блок "Маршрут"
                  _SurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Построить маршрут',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        gap12,
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: YellowButton(
                                text: 'Открыть в Яндекс.Картах',
                                icon: Icons.map_outlined,
                                onTap: () => openUrl(_yandexRouteUrl),
                              ),
                            ),
                            gap8,
                            SizedBox(
                              width: double.infinity,
                              child: YellowButton(
                                text: 'Открыть в Google Maps',
                                icon: Icons.map,
                                onTap: () => openUrl(_googleRouteUrl),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactItem {
  final String title;
  final String phone;
  final String tel;
  const _ContactItem({
    required this.title,
    required this.phone,
    required this.tel,
  });
}

class _PhoneRow extends StatelessWidget {
  const _PhoneRow({
    required this.label,
    required this.onTap,
    this.subtitle,
  });

  final String label;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: cs.surface.withValues(alpha: .95),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.call,
                color: AppColors.deepBlue,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: cs.onSurface,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: textTheme.bodySmall?.copyWith(
                        color: cs.onSurface.withValues(alpha: .7),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: cs.onSurface.withValues(alpha: .6),
            ),
          ],
        ),
      ),
    );
  }
}

class _SurfaceCard extends StatelessWidget {
  const _SurfaceCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: cs.surface.withValues(alpha: .9),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}
