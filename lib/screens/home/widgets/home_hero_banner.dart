import 'package:flutter/material.dart';

import '../home_content.dart';

class HomeHeroBannerLarge extends StatelessWidget {
  const HomeHeroBannerLarge({super.key});

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
              Image.asset(
                'assets/images/blue_fish_with_corals.jpg',
                fit: BoxFit.cover,
              ),
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
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 280),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final line in HomeContent.heroLines) _HeroLine(line),
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
          color: cs.onPrimary,
          shadows: const [
            Shadow(blurRadius: 8, color: Colors.black54, offset: Offset(0, 2)),
          ],
        ),
      ),
    );
  }
}
