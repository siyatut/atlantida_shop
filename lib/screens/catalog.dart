import 'package:flutter/material.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key, this.initialFilter});
  final String? initialFilter; // 'equipment' | 'food' | 'fish'
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String? _activeFilter;

  @override
  void initState() {
    super.initState();
    _activeFilter = widget.initialFilter;
  }

  @override
  Widget build(BuildContext context) {
    // пока заглушка — просто мок-товары; позже подменить на WooCommerce REST
    final products = [
      ('Фильтр аквариумный', 'equipment'),
      ('Скиммер', 'equipment'),
      ('Корм для кошек', 'food'),
      ('Корм для собак', 'food'),
      ('Неоновые рыбки', 'fish'),
      ('Гуппи', 'fish'),
    ].where((p) => _activeFilter == null || p.$2 == _activeFilter).toList();

    return Column(
      children: [
        _Filters(
          active: _activeFilter,
          onSelect: (f) => setState(() => _activeFilter = f),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, i) => ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              tileColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(.2),
              title: Text(products[i].$1),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {}, // TODO: переход на детали товара
            ),
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemCount: products.length,
          ),
        ),
      ],
    );
  }
}

class _Filters extends StatelessWidget {
  const _Filters({required this.active, required this.onSelect});
  final String? active;
  final ValueChanged<String?> onSelect;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        _Chip('Все', active == null, () => onSelect(null)),
        _Chip('Оборудование', active == 'equipment', () => onSelect('equipment')),
        _Chip('Корм', active == 'food', () => onSelect('food')),
        _Chip('Рыбки', active == 'fish', () => onSelect('fish')),
      ]),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip(this.text, this.selected, this.onTap);
  final String text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        selected: selected,
        label: Text(text),
        onSelected: (_) => onTap(),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w700,
          color: selected ? cs.onPrimary : null,
        ),
        selectedColor: cs.primary,
        backgroundColor: cs.surfaceVariant.withOpacity(.25),
      ),
    );
  }
}
