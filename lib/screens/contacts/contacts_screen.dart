import 'package:flutter/material.dart';

import '../../core/constants/app_contacts.dart';
import '../../utils/launcher_utils.dart';
import '../../utils/spacing.dart';
import '../../utils/tab_scroll_padding.dart';
import '../../widgets/yellow_button.dart';

import 'contacts_content.dart';
import 'widgets/contact_phone_row.dart';
import 'widgets/contacts_section_title.dart';
import 'widgets/contacts_surface_card.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Позвонить
                  ContactsSurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ContactsSectionTitle('Позвонить'),
                        gap8,
                        for (int i = 0; i < ContactsContent.phones.length; i++)
                          ...[
                            ContactPhoneRow(
                              label: ContactsContent.phones[i].phoneUi,
                              subtitle: ContactsContent.phones[i].title,
                              onTap: () => makePhoneCall(
                                ContactsContent.phones[i].tel,
                              ),
                            ),
                            if (i != ContactsContent.phones.length - 1) gap8,
                          ],
                      ],
                    ),
                  ),

                  gap12,

                  // Написать
                  ContactsSurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ContactsSectionTitle('Написать'),
                        gap12,
                        Row(
                          children: [
                            Expanded(
                              child: YellowButton(
                                text: 'Telegram',
                                icon: Icons.send_rounded,
                                onTap: () => openUrl(ContactsContent.telegramUrl),
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

                  // Адрес
                  ContactsSurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ContactsSectionTitle('Адрес нашего магазина'),
                        gap8,
                        Text(
                          ContactsContent.addressTitleUi(),
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: cs.onSurface,
                          ),
                        ),
                        gap6,
                        Text(
                          ContactsContent.addressSubtitleUi(),
                          style: textTheme.bodyMedium?.copyWith(
                            color: cs.onSurface.withValues(alpha: .8),
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),

                  gap12,

                  // Маршрут
                  ContactsSurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ContactsSectionTitle('Построить маршрут'),
                        gap12,
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: YellowButton(
                                text: 'Открыть в Яндекс.Картах',
                                icon: Icons.map_outlined,
                                onTap: () => openUrl(ContactsContent.yandexRouteUrl),
                              ),
                            ),
                            gap8,
                            SizedBox(
                              width: double.infinity,
                              child: YellowButton(
                                text: 'Открыть в Google Maps',
                                icon: Icons.map,
                                onTap: () => openUrl(ContactsContent.googleRouteUrl),
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

          SliverToBoxAdapter(
            child: SizedBox(height: tabScrollPadding(context).bottom),
          ),
        ],
      ),
    );
  }
}
