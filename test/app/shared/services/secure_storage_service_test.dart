import 'package:flutter_test/flutter_test.dart';

import 'package:controlefinanceiroapp/app/shared/services/secure_storage_service.dart';

void main() {
  SecureStorageService service;

  setUp(() {
    service = SecureStorageService();
  });

  group('SecureStorageService Test', () {
    test("First Test", () {
      expect(service, isInstanceOf<SecureStorageService>());
    });
  });
}
