import 'package:shared_preferences/shared_preferences.dart';

/// Simple persistence abstraction for the cart. Saves a single JSON string under a key.
class CartPersistence {
  static const _kStorageKey = 'union_shop_cart_v1';

  final SharedPreferences _prefs;

  CartPersistence(this._prefs);

  Future<void> save(String json) async {
    await _prefs.setString(_kStorageKey, json);
  }

  String? load() {
    return _prefs.getString(_kStorageKey);
  }

  Future<void> clear() async {
    await _prefs.remove(_kStorageKey);
  }
}
