import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService extends Disposable {
  final storage = FlutterSecureStorage();

  void storeUid(String uid) async {
    print(uid);
    await storage.write(key: "uid", value: uid);
  }

  void storeToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  void storeExpirationTime(DateTime expirationTime) async {
    await storage.write(
        key: "expirationTime", value: expirationTime.toString());
  }

  Future<String> getUid() async {
    String uid = await storage.read(key: "uid");
    return uid;
  }

  Future<String> getToken() async {
    String token = await storage.read(key: "token");
    return token;
  }

  Future<DateTime> getExpirationTime() async {
    String expirationTimeString = await storage.read(key: "expirationTime");
    if (expirationTimeString != null) {
      DateTime expirationTime = DateTime.tryParse(expirationTimeString);
      return expirationTime;
    }
    return null;
  }

  Future<void> clearAll() async {
    await storage.deleteAll();
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
