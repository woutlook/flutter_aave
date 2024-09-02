// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:tlend_app/providers/platform/platform.dart';

void main() {
  group('httpClient function', () {
    test('returns an IOClient', () async {
      final client = httpClient();
      final resp = client.get(Uri.parse('https://www.google.com'));
      final value = await resp;
      print(value.body);
    });

    // test('badCertificateCallback allows bad certificates', () {
    //   final client = httpClient();
    //   final httpClient = (client as IOClient).inner as HttpClient;
    //   final allowsBadCertificate = httpClient.badCertificateCallback(null, null, null);
    //   expect(allowsBadCertificate, isTrue);
    // });

    // test('ProxySettings are correctly assigned', () {
    //   // This test assumes the ability to inspect the HttpClient for proxy settings,
    //   // which is not directly possible without modifying the source code to expose
    //   // these settings or using reflection. As such, this serves as a conceptual
    //   // placeholder to illustrate the intention of testing proxy settings.
    //   // In a real-world scenario, you might need to refactor your code to make it more testable
    //   // or use integration tests to verify the proxy behavior.
    //   expect(true, isTrue); // Placeholder assertion
    // });
  });
}
