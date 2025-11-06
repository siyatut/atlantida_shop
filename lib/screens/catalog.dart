import 'package:flutter/material.dart';

import '../data/woo/woo_repository.dart';
import '../data/woo/woo_models.dart';
import '../domain/product.dart';
// import 'product_details.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key, this.initialFilter});
  final String? initialFilter;
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String? _activeFilter;
  final _repo = WooRepository();
  bool _loading = true;
  bool _loadingMore = false;
  String? _error;
  List<Product> _items = const [];

  bool _catsLoading = true;
  List<WooCategory> _cats = const [];
  final Map<String, int> _slugToId = {}; // slug -> id

  int _page = 1;
  static const int _perPage = 100;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _activeFilter = widget.initialFilter;
    _loadCategories().then((_) => _load(reset: true));
  }

  Future<void> _loadCategories() async {
    setState(() => _catsLoading = true);
    try {
      final cats = await _repo.categories(perPage: 100);
      // Оставим только те, что видим в макете:
      const desired = {
        'gryzuny': 'Грызуны',
        'koshki': 'Кошки',
        'pticy': 'Птицы', // иногда slug может быть pticy/ptitsy
        'ptitsy': 'Птицы',
        'rybki': 'Рыбки',
        'sobaki': 'Собаки',
      };
      final filtered = <WooCategory>[];
      for (final c in cats) {
        if (desired.keys.contains(c.slug)) {
          filtered.add(c);
          _slugToId[c.slug] = c.id;
        }
      }
      setState(() {
        _cats = filtered;
      });
    } catch (e) {
      // ignore: avoid_print
      print('Failed to load categories: $e');
    } finally {
      setState(() => _catsLoading = false);
    }
  }

  Future<void> _load({bool reset = false}) async {
    if (reset) {
      setState(() {
        _loading = true;
        _error = null;
        _page = 1;
        _hasMore = true;
        _items = const [];
      });
    } else {
      if (!_hasMore || _loadingMore) return;
      setState(() => _loadingMore = true);
    }
    try {
      final id = _activeFilter == null ? null : _slugToId[_activeFilter!];
      final data = await _repo.products(
        page: _page,
        perPage: _perPage,
        categoryId: id,
      );
      setState(() {
        _items = [..._items, ...data];
        _hasMore = data.length == _perPage;
        if (_hasMore) _page += 1;
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (!mounted) return;
      if (reset) {
        setState(() => _loading = false);
      } else {
        setState(() => _loadingMore = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = _items;
    return Column(
      children: [
        _DynamicFilters(
          loading: _catsLoading,
          categories: _cats,
          activeSlug: _activeFilter,
          onSelect: (slug) {
            setState(() => _activeFilter = slug);
            _load(reset: true); // смена фильтра — сброс и новая загрузка
          },
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
              onRefresh: () => _load(reset: true),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (_, i) {
                  // последний элемент — это футер «Показать ещё»
                  if (i == products.length) {
                    return _LoadMoreFooter(
                      visible: _hasMore,
                      loading: _loadingMore,
                      onTap: () => _load(reset: false),
                    );
                  }
                  final item = products[i];
                  return ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    tileColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest.withValues(alpha: .2),
                    leading: (item.image != null)
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(item.image!),
                          )
                        : const CircleAvatar(
                            child: Icon(Icons.image_not_supported_outlined),
                          ),
                    title: Text(item.title),
                    subtitle: Text(
                      (item.price != null && item.price!.isNotEmpty)
                          ? '${item.price} руб.'
                          : 'Цена по запросу',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    // onTap: () {
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (_) => ProductDetailsScreen(product: item),
                    //     ),
                    //   );
                    // },
                  );
                },
                separatorBuilder: (_, i) => i < products.length - 1
                    ? const SizedBox(height: 8)
                    : const SizedBox.shrink(),
                itemCount: products.length + 1, // +1 под футер
              ),
            ),
          ),
      ],
    );
  }
}

class _LoadMoreFooter extends StatelessWidget {
  const _LoadMoreFooter({
    required this.visible,
    required this.loading,
    required this.onTap,
  });
  final bool visible;
  final bool loading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();
    if (loading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: OutlinedButton(
          onPressed: onTap,
          child: const Text('Показать ещё'),
        ),
      ),
    );
  }
}

class _DynamicFilters extends StatelessWidget {
  const _DynamicFilters({
    required this.loading,
    required this.categories,
    required this.activeSlug,
    required this.onSelect,
  });

  final bool loading;
  final List<WooCategory> categories;
  final String? activeSlug;
  final ValueChanged<String?> onSelect;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: LinearProgressIndicator(minHeight: 2),
      );
    }

    final chips = <Widget>[
      _chip(
        context,
        label: 'Все',
        selected: activeSlug == null,
        onTap: () => onSelect(null),
      ),
    ];

    final sorted = [...categories]..sort((a, b) => a.name.compareTo(b.name));
    for (final c in sorted) {
      chips.add(
        _chip(
          context,
          label: c.name,
          selected: activeSlug == c.slug,
          onTap: () => onSelect(c.slug),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      scrollDirection: Axis.horizontal,
      child: Row(children: chips),
    );
  }

  Widget _chip(
    BuildContext context, {
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        selected: selected,
        label: Text(label),
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
