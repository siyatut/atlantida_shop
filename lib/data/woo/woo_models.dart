class WooCategory {
  final int id;
  final String name;
  final String slug;
  final int parent;

  WooCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.parent,
  });

  factory WooCategory.fromJson(Map<String, dynamic> json) => WooCategory(
        id: json['id'] as int,
        name: json['name'] as String? ?? '',
        slug: json['slug'] as String? ?? '',
        parent: json['parent'] as int? ?? 0,
      );
}
