import 'dart:convert';
import 'package:http/http.dart' as http;

import 'woo_config.dart';

class WooClient {
  final http.Client _http;
  final WooConfig _config;
  final bool _ownsHttpClient;

  WooClient({
    WooConfig? config,
    http.Client? httpClient,
  })  : _config = config ?? WooConfig.fromEnv(),
        _http = httpClient ?? http.Client(),
        _ownsHttpClient = httpClient == null;

  void close() {
    if (_ownsHttpClient) _http.close();
  }

  Uri _uri(String path, [Map<String, dynamic>? query]) {
    final q = <String, String>{...?query?.map((k, v) => MapEntry(k, '$v'))};
    return Uri.parse('${_config.baseUrl}/wp-json/wc/v3/$path')
        .replace(queryParameters: q);
  }

  Map<String, String> get _authHeader {
    final auth = base64Encode(
      utf8.encode('${_config.consumerKey}:${_config.consumerSecret}'),
    );
    return {'authorization': 'Basic $auth'};
  }

  List<dynamic> _decodeListResponse(http.Response res) {
    if (res.statusCode >= 200 && res.statusCode < 300) {
      final decoded = jsonDecode(res.body);
      if (decoded is List) return decoded;
      throw Exception('Woo API error: expected List, got ${decoded.runtimeType}');
    }
    throw Exception('Woo API error ${res.statusCode}: ${res.body}');
  }

  Future<List<dynamic>> getProducts({
    int page = 1,
    int perPage = 20,
    int? categoryId,
  }) async {
    final uri = _uri('products', {
      'page': page,
      'per_page': perPage,
      if (categoryId != null) 'category': categoryId,
    });
    final res = await _http.get(uri, headers: _authHeader);
    return _decodeListResponse(res);
  }

  Future<List<dynamic>> getCategories({
    int perPage = 100,
    int page = 1,
    int? parent,
  }) async {
    final uri = _uri('products/categories', {
      'per_page': perPage,
      'page': page,
      if (parent != null) 'parent': parent,
      'hide_empty': true,
    });
    final res = await _http.get(uri, headers: _authHeader);
    return _decodeListResponse(res);
  }
}
