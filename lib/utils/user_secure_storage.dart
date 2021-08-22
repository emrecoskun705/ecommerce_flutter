import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserTokenSecureStorage {
  static final _storage = FlutterSecureStorage();
  static const _keyToken = 'token';

  static Future setToken(String token) async {
    var data = await _storage.write(key: _keyToken, value: token);
    return data;
  }

  static Future<String?> getToken() async {
    try {
      final data = await _storage.read(key: _keyToken);
      return data;
    } catch (e) {
      return null;
    }
  }

  static Future deleteToken() async {
    var data = await _storage.delete(key: _keyToken);
    return data;
  }

  static Future<bool> checkLoggedIn() async {
    var value = await getToken();

    return value != null;
  }
}
