import '../../domain/product.dart';
import 'woo_client.dart';
import 'woo_models.dart';

class WooRepository {
  final WooClient client;
  WooRepository({WooClient? client}) : client = client ?? WooClient();

  Future<List<Product>> products({
    int page = 1,
    int perPage = 20,
    int? categoryId,
  }) async {
    final raw = await client.getProducts(
      page: page,
      perPage: perPage,
      categoryId: categoryId,
    );
    return raw
        .map((e) => Product.fromWooJson(e as Map<String, dynamic>))
        .toList();
  }
  
  Future<List<WooCategory>> topCategories({int perPage = 100}) async {
    final raw = await client.getCategories(perPage: perPage);
    final list = raw
        .map((e) => WooCategory.fromJson(e as Map<String, dynamic>))
        .toList();
    return list.where((c) => c.parent == 0).toList();
  }

  Future<List<WooCategory>> allCategories({int perPage = 100}) async {
    final raw = await client.getCategories(perPage: perPage);
    return raw
        .map((e) => WooCategory.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

