import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/launcher_utils.dart';
import '../widgets/yellow_button.dart';
import '../utils/spacing.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key, this.onOpenCatalog});

  final VoidCallback? onOpenCatalog;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: _HeroCard(
              title: 'Посетите наш магазин сегодня!',
              subtitle:
                  'Не откладывайте заботу о вашем питомце на потом. '
                  'Посетите магазин зоотоваров Атлантида в Нижнем Новгороде сегодня и найдите все необходимое для вашего любимца. '
                  'Мы гарантируем, что вы останетесь довольны качеством наших товаров и услуг!',
              badgeText: 'Всем покупателям с сайта скидка 10%',
            ),
          ),
          const SliverToBoxAdapter(child: gap12),

          // О магазине + ассортимент (общий текст)
          SliverToBoxAdapter(
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionTitle(
                    'Широкий ассортимент товаров для вашего питомца',
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Зоотовары «Атлантида» в Нижнем Новгороде: Ваш лучший выбор для заботы о питомце!',
                    style: textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: .9),
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Владеть домашним питомцем — это большая ответственность, и каждый заботливый владелец желает предоставить своему питомцу все необходимое для его удовлетворения. '
                    'Магазин зоотоваров Атлантида в Нижнем Новгороде существует, чтобы помочь вам в этом!',
                    style: textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: .85),
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Предлагаем большой выбор зоотоваров, все необходимое для жизни и досуга вашего питомца',
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

          // Преимущества магазина (лист + коротко)
          SliverToBoxAdapter(
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionTitle(
                    'Почему выбирают магазин зоотоваров Атлантида?',
                  ),
                  const SizedBox(height: 12),
                  const _Bullets(
                    items: [
                      'Широкий ассортимент товаров для разных видов питомцев',
                      'Качественные товары от известных производителей',
                      'Консультации профессионалов по выбору товаров и уходу за питомцем',
                      'Доступные цены и регулярные акции и скидки',
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Магазин Атлантида — предлагаем разнообразный выбор зоотоваров и сопутствующих товаров, '
                    'которые удовлетворят все потребности вашего питомца.',
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

          // Фишки/иконки с сайта (короткая сетка)
          const SliverToBoxAdapter(
            child: _SurfaceCard(
              child: _FeatureGrid(
                items: [
                  _Feature(icon: Icons.water_outlined, text: 'Аксессуары и аквариумы'),
                  _Feature(icon: Icons.pets_outlined, text: 'В продаже живые рыбки и растения'),
                  _Feature(icon: Icons.shopping_cart_outlined, text: 'Большой ассортимент товаров'),
                  _Feature(icon: Icons.support_agent_outlined, text: 'Профессиональные консультанты'),
                  _Feature(icon: Icons.favorite_outline, text: 'Клиентоориентированный подход'),
                  _Feature(icon: Icons.attach_money, text: 'Доступные цены'),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: gap12),

          // Категории (аккордеон)
          const SliverToBoxAdapter(
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle('Зоотовары для различных видов животных'),
                  SizedBox(height: 8),
                  _AccordionItem(
                    title: 'Товары для всех видов домашних животных',
                    text:
                        'Товары для всех видов домашних животных, включая собак, кошек, грызунов, птиц, рептилий и рыбок. '
                        'У нас есть все, что нужно вашему питомцу для комфортной и здоровой жизни.',
                  ),
                  _AccordionItem(
                    title: 'Аквариумы и оборудование',
                    text:
                        'Если вы являетесь поклонником аквариумных рыбок, то у нас есть все, что нужно для создания прекрасного мира под водой. '
                        'Широкий выбор аквариумов разных размеров и форм, а также различное оборудование, включая насосы, фильтры, нагреватели и освещение.',
                  ),
                  _AccordionItem(
                    title: 'Корма для животных',
                    text:
                        'Мы понимаем, что правильное питание — это один из ключевых аспектов здоровья вашего питомца. '
                        'Поэтому в нашем магазине вы найдете широкий выбор кормов для всех видов животных. '
                        'У нас есть корма для собак и кошек разных пород и возрастов, а также корма для грызунов, птиц, рептилий и рыбок.',
                  ),
                  _AccordionItem(
                    title: 'Сопутствующие товары',
                    text:
                        'Наш магазин также предлагает различные товары, такие как наполнители для туалетов, миски, поводки, игрушки и многое другое. '
                        'У нас есть все необходимое, чтобы сделать жизнь вашего питомца более комфортной и интересной.',
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
                  _SectionTitle('Зоотовары для различных видов животных'),
                  SizedBox(height: 12),
                  _CategoryCard(
                    title: 'Для рыб',
                    text:
                        'В наличии представлены различные рыбы, а также аквариумы, грунт, растения и многое другое. '
                        'Вас порадует большой ассортимент и приятные цены. '
                        'При покупке аквариума от 5000 рублей – действует доставка.',
                    icon: Icons.water_outlined,
                  ),
                  SizedBox(height: 10),
                  _CategoryCard(
                    title: 'Для грызунов и птиц',
                    text: 'Вы найдете большой ассортимент клеток и кормов.',
                    icon: Icons.flutter_dash_outlined,
                  ),
                  SizedBox(height: 10),
                  _CategoryCard(
                    title: 'Для собак и кошек',
                    text:
                        'В ассортименте вы найдете корма и лакомства, ошейники, лотки. '
                        'Наши продавцы всегда помогут вам с выбором и расскажут все о составлении рациона в зависимости от породы питомца.',
                    icon: Icons.pets_outlined,
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: gap12),

          // CTA в каталог
          SliverToBoxAdapter(
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ИЩИТЕ ЛУЧШЕЕ ДЛЯ СВОЕГО ПИТОМЦА?',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.deepBlue,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ЗООТОВАРЫ АТЛАНТИДА - КАЧЕСТВО КОТОРОЕ ЗАСЛУЖИВАЕТ ВАШ ДРУГ.\n'
                    'УЗНАЙТЕ БОЛЬШЕ! ЗАГЛЯНИТЕ В НАШ КАТАЛОГ НА САЙТЕ!',
                    style: textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: .85),
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton.icon(
                      onPressed: () => onOpenCatalog?.call(),
                      icon: const Icon(Icons.storefront_outlined),
                      label: Text('Перейти в каталог', style: textTheme.labelLarge),
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

          // Отзывы — только плейсхолдер
          SliverToBoxAdapter(
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionTitle('Отзывы наших клиентов'),
                  const SizedBox(height: 8),
                  Text(
                    'Здесь будут отзывы покупателей. '
                    'Подключим подгрузку из источника, где они сейчас хранятся.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: .85),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Заглушка под ленту/карусель отзывов
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: cs.surface.withValues(alpha: .7),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.deepBlue.withValues(alpha: .08),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Карусель отзывов (MVP позже)',
                      style: textTheme.bodyMedium?.copyWith(
                        color: cs.onSurface.withValues(alpha: .6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: gap16),
          // Контакты/CTA
          SliverToBoxAdapter(
            child: _SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionTitle('Связаться с нами'),
                  const SizedBox(height: 8),
                  Text(
                    'Если нужна помощь с выбором — позвоните или напишите нам.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: .85),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
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

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.title,
    required this.subtitle,
    required this.badgeText,
  });

  final String title;
  final String subtitle;
  final String badgeText;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.lightBlue, AppColors.teal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .18),
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
              title,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: AppColors.white,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.white.withValues(alpha: .92),
                height: 1.35,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: cs.surface.withValues(alpha: .95),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badgeText,
                style: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.deepBlue,
                ),
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
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium,
    );
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
                      e,
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
          style: textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.deepBlue,
          ),
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
        border: Border.all(
          color: AppColors.deepBlue.withValues(alpha: .08),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.deepBlue),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.deepBlue,
                  ),
                ),
                const SizedBox(height: 6),
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
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      f.text,
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