import '../../domain/product.dart';
import 'woo_client.dart';

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
}
