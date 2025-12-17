import 'package:flutter/material.dart';

import '../../core/constants/app_contacts.dart';
import '../../utils/launcher_utils.dart';
import '../../utils/tab_scroll_padding.dart';
import '../../utils/spacing.dart';
import '../../utils/text_utils.dart';
import '../../widgets/yellow_button.dart';

import 'about_content.dart';
import 'widgets/about_accordion_item.dart';
import 'widgets/about_bullets.dart';
import 'widgets/about_feature_grid.dart';
import 'widgets/about_hero_card.dart';
import 'widgets/about_section_title.dart';
import 'widgets/about_surface_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key, this.onOpenCatalog});

  final VoidCallback? onOpenCatalog;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final heroTitle = AboutContent.heroTitle();
    final heroSubtitle = AboutContent.heroSubtitle();
    final aboutIntro = AboutContent.intro;

    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AboutHeroCard(
              title: heroTitle,
              subtitle: heroSubtitle,
            ),
          ),
          const SliverToBoxAdapter(child: gap12),

          // 1) О магазине + ассортимент (коротко)
          SliverToBoxAdapter(child: _buildTextSection(context, aboutIntro)),
          const SliverToBoxAdapter(child: gap12),

          // 2) Преимущества магазина
          SliverToBoxAdapter(
            child: AboutSurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AboutSectionTitle('Почему выбирают «Атлантиду»'),
                  gap12,
                  const AboutBullets(items: AboutContent.whyUsBullets),
                  gap12,
                  Text(
                    fixPrepositions(
                      'Мы стремимся сделать заботу о питомце проще: '
                      'помогаем с выбором, советуем правильный уход и предлагаем необходимые товары.',
                    ),
                    style: textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: .85),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: gap12),

          // 3) Фишки/иконки
          const SliverToBoxAdapter(
            child: AboutSurfaceCard(
              child: AboutFeatureGrid(
                items: AboutContent.features,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: gap12),

          // 4) Категории (аккордеон)
          SliverToBoxAdapter(
            child: AboutSurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AboutSectionTitle('Зоотовары для разных питомцев'),
                  gap8,
                  for (final item in AboutContent.accordion) ...[
                    AboutAccordionItem(
                      title: fixPrepositions(item.title),
                      text: fixPrepositions(item.text),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: gap12),

          // 5) CTA перейти в каталог
          SliverToBoxAdapter(
            child: AboutSurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AboutSectionTitle('Посмотреть товары'),
                  gap8,
                  Text(
                    fixPrepositions(
                      'Перейдите в каталог и выберите всё нужное для вашего любимца.',
                    ),
                    style: textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: .85),
                      height: 1.3,
                    ),
                  ),
                  gap12,
                  YellowButton(
                    text: 'Перейти в каталог',
                    icon: Icons.storefront_outlined,
                    onTap: onOpenCatalog ?? () {},
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: gap12),

          // 6) Контакты / CTA
          SliverToBoxAdapter(
            child: AboutSurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AboutSectionTitle('Связаться с нами'),
                  gap8,
                  Text(
                    fixPrepositions(
                      'Если нужна помощь с выбором — позвоните или напишите нам.',
                    ),
                    style: textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: .85),
                      height: 1.3,
                    ),
                  ),
                  gap12,
                  Row(
                    children: [
                      Expanded(
                        child: YellowButton(
                          text: 'Позвонить',
                          icon: Icons.call,
                          onTap: () => makePhoneCall(AppContacts.phone),
                        ),
                      ),
                      hGap(12),
                      Expanded(
                        child: YellowButton(
                          text: 'Написать',
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
          ),

          SliverToBoxAdapter(
            child: SizedBox(height: tabScrollPadding(context).bottom),
          ),
        ],
      ),
    );
  }

  Widget _buildTextSection(BuildContext context, AboutSection s) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AboutSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AboutSectionTitle(splitTitleInTwo(fixPrepositions(s.title))),
          gap8,
          for (final p in s.paragraphs) ...[
            Text(
              fixPrepositions(p),
              style: textTheme.bodyMedium?.copyWith(
                color: cs.onSurface.withValues(alpha: .85),
                height: 1.35,
              ),
            ),
            gap8,
          ],
        ],
      ),
    );
  }
}
