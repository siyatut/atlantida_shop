import 'package:flutter/material.dart';

import '../data/woo/woo_repository.dart';
import '../data/woo/woo_models.dart';
import '../domain/product.dart';
import 'product_details.dart';
import '../theme/app_colors.dart';
import '../widgets/yellow_button.dart';

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

  List<WooCategory> _cats = const [];
  final Map<String, int> _slugToId = {}; // slug -> id

  int _page = 1;
  static const int _perPage = 40;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _activeFilter = widget.initialFilter;
    _init();
  }

  Future<void> _init() async {
    await _loadCategories();
    if (!mounted) return;

    if (_activeFilter == null) {
      final firstSlug = _findFirstAvailableSlug();
      if (firstSlug != null) {
        _activeFilter = firstSlug;
      }
    }
    await _load(reset: true);
  }

  String? _findFirstAvailableSlug() {
    final desiredOrder = ['rybki', 'gryzuny', 'koshki', 'sobaki'];
    for (final slug in desiredOrder) {
      if (_slugToId.containsKey(slug)) {
        return slug;
      }
    }
    return null;
  }

  Future<void> _loadCategories() async {
    try {
      final cats = await _repo.categories();
      _slugToId.clear();
      final List<WooCategory> filtered = [];

      for (final c in cats) {
        final slug = c.slug.toLowerCase();
        if ([
          'rybki',
          'gryzuny',
          'koshki',
          'sobaki',
          'pticzy',
          'reptilii',
        ].contains(slug)) {
          filtered.add(c);
          _slugToId[slug] = c.id;
        }
      }
      if (!mounted) return;
      setState(() => _cats = filtered);
    } catch (e) {
      // ignore: avoid_print
      print('Failed to load categories: $e');
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
      if (mounted) {
        if (reset) {
          setState(() => _loading = false);
        } else {
          setState(() => _loadingMore = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = _items;
    return Column(
      children: [
        _DynamicFilters(
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
                  Text(
                    _error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),

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
                      onTap: () => _load(),
                    );
                  }
                  final item = products[i];
                  return _Card(
                    child: Row(
                      children: [
                        const SizedBox(width: 6),
                        Expanded(child: _ProductImage(url: item.image)),
                        const SizedBox(width: 12),
                        Expanded(
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
                                  color: Color(0xFF17324A),
                                ),
                              ),
                              const SizedBox(height: 8),
                              _PriceText(price: item.price),
                              const SizedBox(height: 12),
                              YellowButton(
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
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.lightBlue,
            strokeWidth: 2.5,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.white.withValues(alpha: .95),
              foregroundColor: AppColors.deepBlue,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: AppColors.deepBlue.withValues(alpha: .25),
                  width: 1.2,
                ),
              ),
              shadowColor: Colors.black.withValues(alpha: .20),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.keyboard_double_arrow_down),
                SizedBox(width: 6),
                Text(
                  'Показать ещё',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                ),
              ],
            ),
          ),
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
    required this.categories,
    required this.activeSlug,
    required this.onSelect,
  });

  final List<WooCategory> categories;
  final String? activeSlug;
  final ValueChanged<String?> onSelect;

  static const _orderedTabs = [
    _TabInfo(slugs: ['rybki'], label: 'Рыбки'),
    _TabInfo(slugs: ['gryzuny'], label: 'Грызуны'),
    _TabInfo(slugs: ['koshki'], label: 'Кошки'),
    _TabInfo(slugs: ['sobaki'], label: 'Собаки'),
    _TabInfo(slugs: ['pticzy'], label: 'Птицы'),
    _TabInfo(slugs: ['reptilii'], label: 'Рептилии'),
  ];

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: LinearProgressIndicator(minHeight: 2),
      );
    }

    final chips = <Widget>[];

    for (final tab in _orderedTabs) {
      final category = categories.cast<WooCategory?>().firstWhere((c) {
        if (c == null) return false;
        final slug = c.slug.toLowerCase();
        return tab.slugs.contains(slug);
      }, orElse: () => null);

      if (category == null) continue;

      final slug = category.slug.toLowerCase();
      final bool selected = activeSlug == slug;

      chips.add(
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ChoiceChip(
            selected: selected,
            showCheckmark: false,
            onSelected: (_) => onSelect(slug),
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selected) ...[
                  const Icon(Icons.check, size: 18, color: Colors.white),
                  const SizedBox(width: 4),
                ],
                Text(tab.label),
              ],
            ),
            labelStyle: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: selected ? Colors.white : AppColors.deepBlue,
            ),
            selectedColor: AppColors.teal,
            backgroundColor: Colors.white.withValues(alpha: .95),
            side: BorderSide(
              color: selected ? AppColors.teal : Colors.transparent,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      scrollDirection: Axis.horizontal,
      child: Row(children: chips),
    );
  }
}

class _TabInfo {
  final List<String> slugs;
  final String label;
  const _TabInfo({required this.slugs, required this.label});
}
