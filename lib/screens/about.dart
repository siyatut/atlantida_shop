import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('О магазине «Атлантида»', style: textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(
          'Зоомагазин в Нижнем Новгороде. Большой выбор аквариумов, '
          'оборудования, кормов и сопутствующих товаров.',
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        Text('Адрес: ул. Коминтерна, 117', style: textTheme.bodyMedium),
        const SizedBox(height: 6),
        Text('Телефон: 8 (962) 504-60-96', style: textTheme.bodyMedium),
      ],
    );
  }
}
