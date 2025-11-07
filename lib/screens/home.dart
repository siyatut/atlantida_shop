import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _HeroBannerLarge()),
          SliverToBoxAdapter(child: _gap16()),
          SliverToBoxAdapter(
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionTitle('Магазин зоотоваров в Нижнем Новгороде.'),
                  const SizedBox(height: 6),
                  Text(
                    '9 лет опыта, более 3 000 наименований.\n'
                    'Любовь к питомцам начинается здесь.',
                    style: TextStyle(
                      color: cs.onSurface.withValues(alpha: .85),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      _YellowButton(
                        text: 'Позвонить',
                        onTap: () => launchUrl(Uri.parse('tel:+79625046096')),
                      ),
                      _YellowButton(
                        text: 'Написать',
                        onTap: () =>
                            launchUrl(Uri.parse('mailto:rnti43@yandex.ru')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: _gap12()),
          // Преимущества
          const SliverToBoxAdapter(
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle('Преимущества'),
                  SizedBox(height: 12),
                  _AdvList(
                    items: [
                      _Adv(
                        icon: Icons.local_shipping_outlined,
                        title: 'Доставка на дом',
                        text:
                            'При покупке аквариума от 5 000 ₽ — доступна доставка на дом.',
                      ),
                      _Adv(
                        icon: Icons.price_check_outlined,
                        title: 'Держим низкие цены',
                        text:
                            'Более 9 лет предлагаем товары по доступным ценам.',
                      ),
                      _Adv(
                        icon: Icons.inventory_2_outlined,
                        title: 'Большой ассортимент',
                        text:
                            'Аквариумы, фильтры, корма, игрушки и многое другое.',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: _gap12()),
          // Информационный callout
          SliverToBoxAdapter(
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionTitle('Качество и поставщики'),
                  const SizedBox(height: 6),
                  Text(
                    'Работаем напрямую с производителями аквариумов из Китая и России.\n'
                    'Все корма сертифицированы и соответствуют ГОСТу.',
                    style: TextStyle(
                      color: cs.onSurface.withValues(alpha: .85),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const _InfoPill(
                    icon: Icons.card_giftcard_outlined,
                    text: 'Бесплатная доставка аквариума от 5 000 руб',
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: _gap12()),
          // Быстрые категории (кнопки-ярлыки, как на сайте «ЗООТОВАРЫ…»)
          const SliverToBoxAdapter(
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle('Зоотовары'),
                  SizedBox(height: 10),
                  _TagGrid(
                    tags: [
                      'Аквариумы',
                      'Оборудование',
                      'Корма для ваших домашних питомцев',
                      'И другие сопутствующие товары',
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: _gap16()),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _HeroBannerLarge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              cs.primaryContainer.withValues(alpha: .20),
              cs.primary.withValues(alpha: .25),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Текстовая колонка
            const Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeroLine('ЗООТОВАРЫ'),
                  _HeroLine('АКВАРИУМЫ'),
                  _HeroLine('ОБОРУДОВАНИЕ'),
                  _HeroLine('КОРМА ДЛЯ ВАШИХ'),
                  _HeroLine('ДОМАШНИХ ЛЮБИМЦЕВ'),
                  _HeroLine('И ДРУГИЕ'),
                  _HeroLine('СОПУТСТВУЮЩИЕ ТОВАРЫ'),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                   'assets/images/home_banner.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroLine extends StatelessWidget {
  const _HeroLine(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w900,
          letterSpacing: .2,
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

class _Adv {
  final IconData icon;
  final String title;
  final String text;
  const _Adv({required this.icon, required this.title, required this.text});
}

class _AdvList extends StatelessWidget {
  const _AdvList({required this.items});
  final List<_Adv> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // две колонки, если ширина контейнера > 380
        final twoCols = constraints.maxWidth > 380;
        final gap = 12.0;
        final itemWidth = twoCols
            ? (constraints.maxWidth - gap) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: items
              .map(
                (e) => SizedBox(
                  width: itemWidth,
                  child: _AdvCard(adv: e),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _AdvCard extends StatelessWidget {
  const _AdvCard({required this.adv});
  final _Adv adv;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: .25),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(adv.icon, size: 28),
          const SizedBox(height: 8),
          Text(adv.title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(
            adv.text,
            style: TextStyle(
              color: cs.onSurface.withValues(alpha: .8),
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cs.primary.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.primary.withValues(alpha: .3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: cs.primary),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(color: cs.onSurface, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
    );
  }
}

class _YellowButton extends StatelessWidget {
  const _YellowButton({required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFFF5BE41),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onTap,
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w800)),
    );
  }
}

class _TagGrid extends StatelessWidget {
  const _TagGrid({required this.tags});
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags
          .map(
            (t) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest.withValues(alpha: .25),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white10),
              ),
              child: Text(
                t,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          )
          .toList(),
    );
  }
}

Widget _gap12() => const SizedBox(height: 12);
Widget _gap16() => const SizedBox(height: 16);
