import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/launcher_utils.dart';
import '../widgets/yellow_button.dart';
import '../utils/spacing.dart';

Color _cardBg(BuildContext context) =>
    Theme.of(context).colorScheme.surface.withValues(alpha: .9);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.onOpenCatalog});

  final VoidCallback? onOpenCatalog;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: _HeroBannerLarge()),
          const SliverToBoxAdapter(child: gap16),
          SliverToBoxAdapter(
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionTitle('Зоомагазин в Нижнем Новгороде'),
                  const SizedBox(height: 6),
                  Text(
                    '11 лет опыта. 3 000+ наименований.\nЛюбовь к питомцам начинается здесь!',
                    style: textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: .85),
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
          const SliverToBoxAdapter(child: gap12),
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
                            'При покупке аквариума от 5\u00A0000\u00A0₽ доставим на дом.',
                      ),
                      _Adv(
                        icon: Icons.attach_money,
                        title: 'Держим низкие цены',
                        text:
                            'Более 11 лет мы предлагаем товары по доступным ценам.',
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
          const SliverToBoxAdapter(child: gap12),
          // Качество и поставщики
          SliverToBoxAdapter(
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionTitle('Качество и поставщики'),
                  const SizedBox(height: 8),
                  Text(
                    'Все товары, представленные в магазине «Атлантида», соответствуют стандартам.\n '
                    '\nМы выбираем для вас проверенных поставщиков и качественную продукцию.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: .85),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        onOpenCatalog?.call();
                      },
                      icon: const Icon(Icons.storefront_outlined),
                      label: Text(
                        'Перейти в каталог',
                        style: textTheme.labelLarge,
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.deepBlue,
                        side: const BorderSide(color: AppColors.deepBlue),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: gap12),
          const SliverToBoxAdapter(
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle('Почему выбирают «Атлантиду»'),
                  SizedBox(height: 12),
                  _FeatureGrid(
                    items: [
                      _Feature(
                        icon: Icons.water_outlined,
                        text: 'Аксессуары и аквариумы',
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
                        icon: Icons.emoji_people_outlined,
                        text: 'Клиентоориентированный подход',
                      ),
                      _Feature(
                        icon: Icons.attach_money,
                        text: 'Доступные цены',
                      ),
                      _Feature(
                        icon: Icons.grass_outlined,
                        text: 'Живые рыбки и растения для аквариумов',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: gap16),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _HeroBannerLarge extends StatelessWidget {
  const _HeroBannerLarge();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: 220,
          decoration: BoxDecoration(border: Border.all(color: Colors.white10)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Фон-картинка
              Image.asset(
                'assets/images/blue_fish_with_corals.jpg',
                fit: BoxFit.cover,
              ),
              // Затемняющий градиент слева → вправо
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: .60),
                      Colors.black.withValues(alpha: .20),
                      Colors.black.withValues(alpha: .05),
                    ],
                  ),
                ),
              ),
              // Текст поверх фото
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 280),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _HeroLine('ЗООТОВАРЫ'),
                        _HeroLine('АКВАРИУМЫ'),
                        _HeroLine('ОБОРУДОВАНИЕ'),
                        _HeroLine('КОРМА ДЛЯ ВАШИХ'),
                        _HeroLine('ДОМАШНИХ ЛЮБИМЦЕВ'),
                        _HeroLine('И ДРУГИЕ ТОВАРЫ'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        text,
        style: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w900,
          height: 1.15,
          letterSpacing: .2,
          color:cs.onPrimary,
          shadows: const [
            Shadow(blurRadius: 8, color: Colors.black54, offset: Offset(0, 2)),
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
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _cardBg(context),
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg(context),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.white.withValues(alpha: .06),
            offset: const Offset(-2, -2),
            blurRadius: 6,
          ),
          // мягкая тень снизу
          BoxShadow(
            color: Colors.black.withValues(alpha: .12),
            offset: const Offset(3, 3),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: cs.surface.withValues(alpha: .95),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .05),
                  blurRadius: 6,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Icon(adv.icon, color: AppColors.deepBlue, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  adv.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  adv.text,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: cs.onSurface.withValues(alpha: .75),
                    height: 1.3,
                  ),
                ),
              ],
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
                  Icon(f.icon, color: AppColors.deepBlue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      f.text,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
