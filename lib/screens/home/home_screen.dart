import 'package:flutter/material.dart';

import '../../core/constants/app_contacts.dart';
import '../../theme/app_colors.dart';
import '../../utils/launcher_utils.dart';
import '../../utils/spacing.dart';
import '../../utils/tab_scroll_padding.dart';
import '../../widgets/yellow_button.dart';

import 'home_content.dart';
import 'widgets/home_advantages.dart';
import 'widgets/home_feature_grid.dart';
import 'widgets/home_hero_banner.dart';
import 'widgets/home_section_title.dart';
import 'widgets/home_surface_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.onOpenCatalog});

  final VoidCallback? onOpenCatalog;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: HomeHeroBannerLarge()),
          const SliverToBoxAdapter(child: gap16),

          SliverToBoxAdapter(
            child: HomeSurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeSectionTitle(HomeContent.aboutTitle),
                  const SizedBox(height: 6),
                  Text(
                    HomeContent.aboutText,
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

          const SliverToBoxAdapter(
            child: HomeSurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeSectionTitle(HomeContent.advantagesTitle),
                  SizedBox(height: 12),
                  HomeAdvantages(items: HomeContent.advantages),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: gap12),

          SliverToBoxAdapter(
            child: HomeSurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeSectionTitle(HomeContent.qualityTitle),
                  const SizedBox(height: 8),
                  Text(
                    HomeContent.qualityText,
                    style: textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: .85),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => onOpenCatalog?.call(),
                      icon: const Icon(Icons.storefront_outlined, size: 20),
                      label: Text(
                        'Перейти в каталог',
                        style: textTheme.labelLarge,
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.deepBlue,
                        side: BorderSide(
                          color: AppColors.deepBlue.withValues(alpha: .9),
                          width: 1.4,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: gap12),

          const SliverToBoxAdapter(
            child: HomeSurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeSectionTitle(HomeContent.whyTitle),
                  SizedBox(height: 12),
                  HomeFeatureGrid(items: HomeContent.whyFeatures),
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
