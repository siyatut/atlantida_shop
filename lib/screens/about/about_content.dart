import 'package:flutter/material.dart';
import '../../utils/text_utils.dart';

class AboutContent {
  static String heroTitle() => fixPrepositions(
        'Не откладывайте заботу \nо вашем питомце на потом!',
      );

  static String heroSubtitle() => fixPrepositions(
        'Посетите зоомагазин «Атлантида» в Нижнем Новгороде — у нас есть всё для здоровья и комфорта вашего любимца. '
        'Качественные товары, честные цены и помощь консультантов.',
      );

  static const intro = AboutSection(
    'Широкий ассортимент товаров для вашего питомца',
    [
      'Зоомагазин «Атлантида» в Нижнем Новгороде — ваш лучший выбор для заботы о питомце.',
      'Более 11 лет подбираем корма, оборудование и аксессуары для животных разных видов: от рыбок и птиц до собак и кошек.',
      'Нам важно, чтобы вашему любимцу было комфортно и безопасно, поэтому мы сотрудничаем только с проверенными годами производителями.',
    ],
  );

  static const whyUsBullets = <String>[
    'Широкий ассортимент товаров для разных видов питомцев',
    'Качественные товары от известных производителей',
    'Консультации профессионалов по выбору товаров и уходу',
    'Честные и доступные цены',
  ];

  static const features = <AboutFeatureData>[
    AboutFeatureData(icon: Icons.water_outlined, text: 'Аксессуары и аквариумы'),
    AboutFeatureData(icon: Icons.grass_outlined, text: 'В продаже живые рыбки и растения'),
    AboutFeatureData(icon: Icons.shopping_cart_outlined, text: 'Большой ассортимент товаров'),
    AboutFeatureData(icon: Icons.support_agent_outlined, text: 'Профессиональные консультанты'),
    AboutFeatureData(icon: Icons.favorite_outline, text: 'Клиентоориентированный подход'),
    AboutFeatureData(icon: Icons.attach_money, text: 'Доступные цены'),
  ];

  static const accordion = <AboutAccordionItemData>[
    AboutAccordionItemData(
      title: 'Разнообразие товаров для ваших любимцев',
      text:
          'Товары для всех видов домашних животных, включая собак, кошек, грызунов, птиц, рептилий и рыбок. '
          'У нас есть всё, что нужно вашему питомцу для комфортной и здоровой жизни.',
    ),
    AboutAccordionItemData(
      title: 'Аквариумы и оборудование',
      text:
          'Если любите аквариумных рыбок, в нашем магазине вы найдёте всё для создания прекрасного подводного мира: '
          'аквариумы разных форм и размеров, фильтры, нагреватели, освещение и украшения.',
    ),
    AboutAccordionItemData(
      title: 'Корма для животных',
      text:
          'Правильное питание — ключ к здоровью питомца. '
          'В «Атлантиде» большой выбор кормов для аквариумных рыбок: на каждый день, для роста и окраса. '
          'Также у нас есть корма для собак и кошек разных пород и возрастов, '
          'а ещё для грызунов, птиц и рептилий.',
    ),
    AboutAccordionItemData(
      title: 'Сопутствующие товары',
      text:
          'Наполнители, миски, поводки, игрушки и многое другое. '
          'Мы поможем подобрать всё необходимое, чтобы жизнь вашего питомца была удобной и интересной для вас обоих.',
    ),
  ];
}

class AboutSection {
  final String title;
  final List<String> paragraphs;
  const AboutSection(this.title, this.paragraphs);
}

class AboutFeatureData {
  final IconData icon;
  final String text;
  const AboutFeatureData({required this.icon, required this.text});
}

class AboutAccordionItemData {
  final String title;
  final String text;
  const AboutAccordionItemData({required this.title, required this.text});
}