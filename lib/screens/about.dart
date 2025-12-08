import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/launcher_utils.dart';
import '../utils/spacing.dart';
import '../utils/text_utils.dart';
import '../widgets/yellow_button.dart';
import '../core/app_contacts.dart';

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
      'Посетите магазин зоотоваров Атлантида в Нижнем Новгороде сегодня и найдите все необходимое для вашего любимца. '
      'Мы гарантируем, что вы останетесь довольны качеством наших товаров и услуг!',
    );

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _HeroCard(title: heroTitle, subtitle: heroSubtitle),
          ),

          SliverToBoxAdapter(child: vGap(10)),
          const SliverToBoxAdapter(child: _DiscountBanner()),
          const SliverToBoxAdapter(child: gap12),

          // О магазине + ассортимент
          SliverToBoxAdapter(
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(
                    splitTitleInTwo(
                      fixPrepositions(
                        'Широкий ассортимент товаров для вашего питомца',
                      ),
                    ),
                  ),
                  gap8,
                  Text(
                    fixPrepositions(
                      'Зоотовары «Атлантида» в Нижнем Новгороде: Ваш лучший выбор для заботы о питомце!',
                    ),
                    style: textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: .9),
                      height: 1.35,
                    ),
                  ),
                  gap8,
                  Text(
                    fixPrepositions(
                      'Владеть домашним питомцем — это большая ответственность, и каждый заботливый владелец желает предоставить своему питомцу все необходимое для его удовлетворения. '
                      'Магазин зоотоваров Атлантида в Нижнем Новгороде существует, чтобы помочь вам в этом!',
                    ),
                    style: textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: .85),
                      height: 1.35,
                    ),
                  ),
                  gap8,
                  Text(
                    fixPrepositions(
                      'Предлагаем большой выбор зоотоваров, все необходимое для жизни и досуга вашего питомца',
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

          // Преимущества магазина
          SliverToBoxAdapter(
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(
                    splitTitleInTwo(
                      fixPrepositions(
                        'Почему выбирают магазин зоотоваров Атлантида?',
                      ),
                    ),
                  ),
                  gap12,
                  const _Bullets(
                    items: [
                      'Широкий ассортимент товаров для разных видов питомцев',
                      'Качественные товары от известных производителей',
                      'Консультации профессионалов по выбору товаров и уходу за питомцем',
                      'Доступные цены и регулярные акции и скидки',
                    ],
                  ),
                  gap12,
                  Text(
                    fixPrepositions(
                      'Магазин Атлантида — предлагаем разнообразный выбор зоотоваров и сопутствующих товаров, '
                      'которые удовлетворят все потребности вашего питомца.',
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

          // Фишки/иконки
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

          // Категории (аккордеон)
          SliverToBoxAdapter(
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(
                    fixPrepositions('Зоотовары для различных видов животных'),
                  ),
                  gap8,
                  _AccordionItem(
                    title: fixPrepositions(
                      'Товары для всех видов домашних животных',
                    ),
                    text: fixPrepositions(
                      'Товары для всех видов домашних животных, включая собак, кошек, грызунов, птиц, рептилий и рыбок. '
                      'У нас есть все, что нужно вашему питомцу для комфортной и здоровой жизни.',
                    ),
                  ),
                  _AccordionItem(
                    title: fixPrepositions('Аквариумы и оборудование'),
                    text: fixPrepositions(
                      'Если вы являетесь поклонником аквариумных рыбок, то у нас есть все, что нужно для создания прекрасного мира под водой. '
                      'Широкий выбор аквариумов разных размеров и форм, а также различное оборудование, включая насосы, фильтры, нагреватели и освещение.',
                    ),
                  ),
                  _AccordionItem(
                    title: fixPrepositions('Корма для животных'),
                    text: fixPrepositions(
                      'Мы понимаем, что правильное питание — это один из ключевых аспектов здоровья вашего питомца. '
                      'Поэтому в нашем магазине вы найдете широкий выбор кормов для всех видов животных. '
                      'У нас есть корма для собак и кошек разных пород и возрастов, а также корма для грызунов, птиц, рептилий и рыбок.',
                    ),
                  ),
                  _AccordionItem(
                    title: fixPrepositions('Сопутствующие товары'),
                    text: fixPrepositions(
                      'Наш магазин также предлагает различные товары, такие как наполнители для туалетов, миски, поводки, игрушки и многое другое. '
                      'У нас есть все необходимое, чтобы сделать жизнь вашего питомца более комфортной и интересной.',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: gap12),

          // Категории (карточки)
          SliverToBoxAdapter(
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(
                    fixPrepositions('Зоотовары для различных видов животных'),
                  ),
                  gap12,
                  _CategoryCard(
                    title: fixPrepositions('Для рыб'),
                    text: fixPrepositions(
                      'В наличии представлены различные рыбы, а также аквариумы, грунт, растения и многое другое. '
                      'Вас порадует большой ассортимент и приятные цены. '
                      'При покупке аквариума от 5000 рублей – действует доставка.',
                    ),
                    icon: Icons.water_outlined,
                  ),
                  vGap(10),
                  _CategoryCard(
                    title: fixPrepositions('Для грызунов и птиц'),
                    text: fixPrepositions(
                      'Вы найдете большой ассортимент клеток и кормов.',
                    ),
                    icon: Icons.flutter_dash_outlined,
                  ),
                  vGap(10),
                  _CategoryCard(
                    title: fixPrepositions('Для собак и кошек'),
                    text: fixPrepositions(
                      'В ассортименте вы найдете корма и лакомства, ошейники, лотки. '
                      'Наши продавцы всегда помогут вам с выбором и расскажут все о составлении рациона в зависимости от породы питомца.',
                    ),
                    icon: Icons.pets_outlined,
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: gap12),

          // Контакты / CTA
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

class _DiscountBanner extends StatelessWidget {
  const _DiscountBanner();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final edge1 = AppColors.aqua.withValues(alpha: isDark ? .18 : .10);
    final edge2 = AppColors.teal.withValues(alpha: isDark ? .16 : .08);
    final mid = cs.surface.withValues(alpha: isDark ? .92 : .97);
    final borderColor = AppColors.aqua.withValues(alpha: isDark ? .35 : .18);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [edge1, mid, edge2],
            stops: const [0.0, 0.5, 1.0],
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor, width: 1.2),
          boxShadow: [
            // делаем тень спокойнее, чтобы не давала "черной рамки"
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? .25 : .07),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Всем покупателям\nиз приложения скидка 10%',
            textAlign: TextAlign.center,
            style: textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: cs.onSurface,
              height: 1.2,
            ),
          ),
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

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.title,
    required this.text,
    required this.icon,
  });

  final String title;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surface.withValues(alpha: .85),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.deepBlue.withValues(alpha: .08)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.deepBlue),
          hGap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleSmall?.copyWith(
                    color: AppColors.deepBlue,
                  ),
                ),
                gap8,
                Text(
                  text,
                  style: textTheme.bodyMedium?.copyWith(
                    color: cs.onSurface.withValues(alpha: .85),
                    height: 1.35,
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
