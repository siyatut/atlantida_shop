import 'package:flutter/material.dart';

import '../core/app_contacts.dart';
import '../theme/app_colors.dart';
import '../utils/launcher_utils.dart';
import '../utils/spacing.dart';
import '../utils/text_utils.dart';
import '../widgets/yellow_button.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key, this.onOpenCatalog});

  final VoidCallback? onOpenCatalog;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final heroTitle = fixPrepositions(
      'Не откладывайте заботу о вашем питомце на потом!',
    );
    final heroSubtitle = fixPrepositions(
      'Посетите зоомагазин «Атлантида» в Нижнем Новгороде — у нас есть всё для здоровья и комфорта вашего любимца. '
      'Качественные товары, честные цены и помощь консультантов.',
    );

    final aboutIntro = const _AboutSection(
      'Широкий ассортимент товаров для вашего питомца',
      [
        'Зоотовары «Атлантида» в Нижнем Новгороде — ваш лучший выбор для заботы о питомце.',
        'Мы подбираем корма, оборудование и аксессуары для питомцев разных видов: от рыбок и птиц до собак и кошек.',
        'Нам важно, чтобы вашему любимцу было комфортно и безопасно, поэтому мы выбираем проверенных производителей.',
      ],
    );

    final whyUsBullets = const [
      'Широкий ассортимент товаров для разных видов питомцев',
      'Качественные товары от известных производителей',
      'Консультации профессионалов по выбору товаров и уходу',
      'Доступные цены и регулярные акции и скидки',
    ];

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _HeroCard(title: heroTitle, subtitle: heroSubtitle),
          ),
          const SliverToBoxAdapter(child: gap12),

          // 1) О магазине + ассортимент (коротко)
          SliverToBoxAdapter(
            child: _buildTextSection(context, aboutIntro),
          ),
          const SliverToBoxAdapter(child: gap12),

          // 2) Преимущества магазина
          SliverToBoxAdapter(
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(
                    splitTitleInTwo(
                      fixPrepositions('Почему выбирают «Атлантиду»?'),
                    ),
                  ),
                  gap12,
                  _Bullets(items: whyUsBullets),
                  gap12,
                  Text(
                    fixPrepositions(
                      'Мы стремимся сделать заботу о питомце проще: '
                      'помогаем с выбором, советуем по уходу и предлагаем товары на каждый день.',
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
            child: _SurfaceCard(
              child: _FeatureGrid(
                items: [
                  _Feature(
                    icon: Icons.water_outlined,
                    text: 'Аксессуары и аквариумы',
                  ),
                  _Feature(
                    icon: Icons.pets_outlined,
                    text: 'В продаже живые рыбки и растения',
                  ),
                  _Feature(
                    icon: Icons.shopping_cart_outlined,
                    text: 'Большой ассортимент товаров',
                  ),
                  _Feature(
                    icon: Icons.support_agent_outlined,
                    text: 'Профессиональные консультанты',
                  ),
                  _Feature(
                    icon: Icons.favorite_outline,
                    text: 'Клиентоориентированный подход',
                  ),
                  _Feature(icon: Icons.attach_money, text: 'Доступные цены'),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: gap12),

          // 4) Категории (аккордеон)
          SliverToBoxAdapter(
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(
                    fixPrepositions('Зоотовары для разных питомцев'),
                  ),
                  gap8,
                  _AccordionItem(
                    title: fixPrepositions(
                      'Товары для всех видов домашних животных',
                    ),
                    text: fixPrepositions(
                      'Товары для всех видов домашних животных, включая собак, кошек, грызунов, птиц, рептилий и рыбок. '
                      'У нас есть всё, что нужно вашему питомцу для комфортной и здоровой жизни.',
                    ),
                  ),
                  _AccordionItem(
                    title: fixPrepositions('Аквариумы и оборудование'),
                    text: fixPrepositions(
                      'Если вы любите аквариумных рыбок, у нас есть всё для создания прекрасного подводного мира: '
                      'аквариумы разных размеров и форм, насосы, фильтры, нагреватели и освещение.',
                    ),
                  ),
                  _AccordionItem(
                    title: fixPrepositions('Корма для животных'),
                    text: fixPrepositions(
                      'Правильное питание — ключ к здоровью питомца. '
                      'У нас вы найдёте корма для собак и кошек разных пород и возрастов, '
                      'а также для грызунов, птиц, рептилий и рыбок.',
                    ),
                  ),
                  _AccordionItem(
                    title: fixPrepositions('Сопутствующие товары'),
                    text: fixPrepositions(
                      'Наполнители, миски, поводки, игрушки и многое другое. '
                      'Мы поможем подобрать всё необходимое, чтобы жизнь вашего питомца была удобной и интересной.',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: gap12),

          // 5) CTA перейти в каталог
          SliverToBoxAdapter(
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionTitle('Посмотреть товары'),
                  gap8,
                  Text(
                    fixPrepositions(
                      'Откройте каталог и выберите всё нужное для вашего любимца.',
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
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionTitle('Связаться с нами'),
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

          const SliverToBoxAdapter(child: gap24),
        ],
      ),
    );
  }

  Widget _buildTextSection(BuildContext context, _AboutSection s) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(splitTitleInTwo(fixPrepositions(s.title))),
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

class _AboutSection {
  final String title;
  final List<String> paragraphs;
  const _AboutSection(this.title, this.paragraphs);
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: cs.onSurface,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: textTheme.bodyMedium?.copyWith(
                color: cs.onSurface.withValues(alpha: .85),
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SurfaceCard extends StatelessWidget {
  const _SurfaceCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
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
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.titleMedium);
  }
}

class _Bullets extends StatelessWidget {
  const _Bullets({required this.items});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '— ',
                    style: textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: .8),
                      height: 1.35,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      fixPrepositions(e),
                      style: textTheme.bodyMedium?.copyWith(
                        color: cs.onSurface.withValues(alpha: .88),
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _AccordionItem extends StatelessWidget {
  const _AccordionItem({required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(bottom: 8),
        iconColor: AppColors.deepBlue,
        collapsedIconColor: AppColors.deepBlue,
        title: Text(
          title,
          style: textTheme.titleSmall?.copyWith(color: AppColors.deepBlue),
        ),
        children: [
          Text(
            text,
            style: textTheme.bodyMedium?.copyWith(
              color: cs.onSurface.withValues(alpha: .85),
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _Feature {
  final IconData icon;
  final String text;
  const _Feature({required this.icon, required this.text});
}

class _FeatureGrid extends StatelessWidget {
  const _FeatureGrid({required this.items});
  final List<_Feature> items;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final twoCols = constraints.maxWidth > 380;
        final gap = 12.0;
        final itemWidth = twoCols
            ? (constraints.maxWidth - gap) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: gap,
          runSpacing: 10,
          children: items.map((f) {
            return SizedBox(
              width: itemWidth,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(f.icon, color: AppColors.deepBlue, size: 20),
                  hGap(8),
                  Expanded(
                    child: Text(
                      fixPrepositions(f.text),
                      style: textTheme.bodyMedium?.copyWith(
                        color: cs.onSurface.withValues(alpha: .9),
                        height: 1.25,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
