import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:http/io_client.dart';
import 'package:flutter_socks_proxy/socks_proxy.dart';

http.Client httpClient() {
  final client = createProxyHttpClient()
    ..findProxy = (uri) {
      if (defaultTargetPlatform == TargetPlatform.android) {
        return 'SOCKS5 10.0.2.2:1080';
      } else {
        return 'SOCKS5 127.0.0.1:1080';
      }
    };
  return IOClient(client);
}
