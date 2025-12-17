import 'package:flutter/material.dart';
import '../../../utils/text_utils.dart';

class AboutBullets extends StatelessWidget {
  const AboutBullets({super.key, required this.items});
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
