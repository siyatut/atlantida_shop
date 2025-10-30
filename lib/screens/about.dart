import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text('О магазине «Атлантида»', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        SizedBox(height: 8),
        Text(
          'Зоомагазин в Нижнем Новгороде. Большой выбор аквариумов, '
          'оборудования, кормов и сопутствующих товаров.',
        ),
        SizedBox(height: 16),
        Text('Адрес: ул. Коминтерна, 117'),
        SizedBox(height: 6),
        Text('Телефон: 8 (962) 504-60-96'),
      ],
    );
  }
}
