import 'package:campusflow/core/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  tearDown(() => debugDefaultTargetPlatformOverride = null);

  test('choisit 10.0.2.2 sur Android et localhost ailleurs', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    expect(defaultApiBaseUrl(), 'http://10.0.2.2:3000');

    debugDefaultTargetPlatformOverride = TargetPlatform.windows;
    expect(defaultApiBaseUrl(), 'http://localhost:3000');

    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    expect(defaultApiBaseUrl(), 'http://localhost:3000');
  });
}
