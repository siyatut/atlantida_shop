import 'dart:convert';

import 'package:http/http.dart' as http;

import 'woo_config.dart';

class WooClient {
  final http.Client _http;
  WooClient({http.Client? httpClient}) : _http = httpClient ?? http.Client();

  Uri _uri(String path, [Map<String, dynamic>? query]) {
    final q = <String, String>{...?query?.map((k, v) => MapEntry(k, '$v'))};
    return Uri.parse(
      '$wooBaseUrl/wp-json/wc/v3/$path',
    ).replace(queryParameters: q);
  }

  Map<String, String> get _authHeader {
    final auth = base64Encode(
      utf8.encode('$wooConsumerKey:$wooConsumerSecret'),
    );
    return {'authorization': 'Basic $auth'};
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
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return jsonDecode(res.body) as List<dynamic>;
    }
    throw Exception('Woo API error ${res.statusCode}: ${res.body}');
  }
}
