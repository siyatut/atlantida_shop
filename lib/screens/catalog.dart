import 'package:flutter/material.dart';

import '../data/woo/woo_repository.dart';
import '../domain/product.dart';
// import 'product_details.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key, this.initialFilter});
  final String? initialFilter; // 'equipment' | 'food' | 'fish'
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String? _activeFilter;
  final _repo = WooRepository();
  bool _loading = true;
  String? _error;
  List<Product> _items = const [];

  @override
  void initState() {
    super.initState();
    _activeFilter = widget.initialFilter;
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final data = await _repo.products();
      setState(() => _items = data);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = _items
        .where((p) => _activeFilter == null || p.category == _activeFilter)
        .toList();

    return Column(
      children: [
        _Filters(
          active: _activeFilter,
          onSelect: (f) => setState(() => _activeFilter = f),
        ),
        if (_loading)
          const Expanded(child: Center(child: CircularProgressIndicator())),
        if (!_loading && _error != null)
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Не удалось загрузить товары'),
                  const SizedBox(height: 8),
                  Text(_error!, style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: _load,
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            ),
          ),
        if (!_loading && _error == null)
          Expanded(
            child: RefreshIndicator(
              onRefresh: _load,
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (_, i) => ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tileColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest.withValues(alpha: .2),
                  leading: (products[i].image != null)
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(products[i].image!),
                        )
                      : const CircleAvatar(
                          child: Icon(Icons.image_not_supported_outlined),
                        ),
                  title: Text(products[i].title),
                  subtitle: Text(
                    (products[i].price != null && products[i].price!.isNotEmpty)
                        ? '${products[i].price} руб.'
                        : 'Цена по запросу',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  // onTap: () {
                  //   Navigator.of(context).push(
                  //     MaterialPageRoute(
                  //       builder: (_) =>
                  //           ProductDetailsScreen(product: products[i]),
                  //     ),
                  //   );
                  // },
                ),
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemCount: products.length,
              ),
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
      child: Row(
        children: [
          _Chip('Все', active == null, () => onSelect(null)),
          _Chip(
            'Оборудование',
            active == 'equipment',
            () => onSelect('equipment'),
          ),
          _Chip('Корм', active == 'food', () => onSelect('food')),
          _Chip('Рыбки', active == 'fish', () => onSelect('fish')),
        ],
      ),
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
        backgroundColor: cs.surfaceContainerHighest.withValues(alpha: .25),
      ),
    );
  }
}
