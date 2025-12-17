import 'package:atlantida_shop/core/env.dart';

class WooConfig {
  final String baseUrl;
  final String consumerKey;
  final String consumerSecret;

  const WooConfig({
    required this.baseUrl,
    required this.consumerKey,
    required this.consumerSecret,
  });

  factory WooConfig.fromEnv() => WooConfig(
        baseUrl: Env.get('WOO_BASE_URL'),
        consumerKey: Env.get('WOO_CONSUMER_KEY'),
        consumerSecret: Env.get('WOO_CONSUMER_SECRET'),
      );
}
