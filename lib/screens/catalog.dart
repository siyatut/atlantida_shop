import 'package:flutter/material.dart';

import '../data/woo/woo_repository.dart';
import '../data/woo/woo_models.dart';
import '../domain/product.dart';
import 'product_details.dart';

import 'package:cached_network_image/cached_network_image.dart';

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
                  // последний элемент — футер «Показать ещё»
                  if (i == products.length) {
                    return _LoadMoreFooter(
                      visible: _hasMore,
                      loading: _loadingMore,
                      onTap: () => _load(reset: false),
                    );
                  }
                  final item = products[i];
                  return _Card(
                    child: Row(
                      children: [
                        const SizedBox(width: 6),
                        Expanded(
                          flex: 1,
                          child: _ProductImage(url: item.image),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                               // maxLines: 2,
                              //  overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 17,
                                  color: Color(
                                    0xFF17324A,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              _PriceText(price: item.price),
                              const SizedBox(height: 12),
                              _YellowButton(
                                text: 'Подробнее',
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          ProductDetailsScreen(product: item),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  );
                },
                separatorBuilder: (_, i) => i < products.length - 1
                    ? const SizedBox(height: 12)
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

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .20),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: child,
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({this.url});
  final String? url;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Colors.grey.shade200,
          child: (url == null || url!.isEmpty)
              ? const Icon(Icons.image_outlined, color: Colors.black26)
              : CachedNetworkImage(
                  imageUrl: url!,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (_, __, ___) => const Icon(
                    Icons.broken_image_outlined,
                    color: Colors.black26,
                  ),
                ),
        ),
      ),
    );
  }
}

class _YellowButton extends StatelessWidget {
  const _YellowButton({required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: const Color(0xFFF6C445),
        foregroundColor: const Color(0xFF132B45),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
      ),
    );
  }
}

class _PriceText extends StatelessWidget {
  const _PriceText({this.price});
  final String? price;

  @override
  Widget build(BuildContext context) {
    final hasPrice = price != null && price!.isNotEmpty;
    return Text(
      hasPrice ? '$price руб.' : 'Цена по запросу',
      style: TextStyle(
        color: hasPrice ? const Color(0xFF0E3A69) : Colors.black54,
        fontWeight: FontWeight.w700,
        fontSize: 15,
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
