import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/cart_item.dart';
import 'storage/cart_persistence.dart';

/// A reactive, testable cart service implementing required operations.
class CartService extends ChangeNotifier {
  final Map<String, CartItem> _items = {};
  final CartPersistence _persistence;

  Timer? _debounce;

  CartService._(this._persistence);

  static Future<CartService> create() async {
    final prefs = await SharedPreferences.getInstance();
    final persistence = CartPersistence(prefs);
    final service = CartService._(persistence);
    service._restoreFromStorage();
    return service;
  }

  // For tests: allow overriding persistence
  CartService.forTest(this._persistence);

  List<CartItem> getItems() => _items.values.toList(growable: false);

  int getItemCount() => _items.values.fold(0, (s, i) => s + i.quantity);

  double getSubtotal() =>
      _items.values.fold(0.0, (s, i) => s + (i.unitPrice * i.quantity));

  double getTax([double rate = 0.0]) =>
      double.parse((getSubtotal() * rate).toStringAsFixed(2));

  double getTotal([double taxRate = 0.0]) =>
      double.parse((getSubtotal() + getTax(taxRate)).toStringAsFixed(2));

  void addItem({
    required String productId,
    String? sku,
    required String name,
    required double unitPrice,
    int quantity = 1,
    Map<String, String> attributes = const {},
    String? imageUrl,
    Map<String, dynamic>? metadata,
  }) {
    final item = CartItem(
      productId: productId,
      sku: sku,
      name: name,
      unitPrice: unitPrice,
      quantity: quantity,
      attributes: attributes,
      imageUrl: imageUrl,
      metadata: metadata,
    );

    final key = item.stableKey();
    if (_items.containsKey(key)) {
      final existing = _items[key]!;
      final merged = existing.copyWith(quantity: existing.quantity + quantity);
      _items[key] = merged;
    } else {
      _items[key] = item;
    }
    notifyListeners();
    _schedulePersist();
  }

  void updateItemQuantity(String itemKey, int newQuantity) {
    if (!_items.containsKey(itemKey)) return;
    final q = newQuantity < 1 ? 1 : newQuantity;
    final item = _items[itemKey]!;
    _items[itemKey] = item.copyWith(quantity: q);
    notifyListeners();
    _schedulePersist();
  }

  void updateItemAttributes(String itemKey, Map<String, String> attributes) {
    if (!_items.containsKey(itemKey)) return;
    final item = _items[itemKey]!;
    // replace item with new key (attributes affect identity)
    _items.remove(itemKey);
    final newItem = item.copyWith(attributes: attributes);
    final newKey = newItem.stableKey();
    if (_items.containsKey(newKey)) {
      // merge quantities
      final existing = _items[newKey]!;
      _items[newKey] =
          existing.copyWith(quantity: existing.quantity + newItem.quantity);
    } else {
      _items[newKey] = newItem;
    }
    notifyListeners();
    _schedulePersist();
  }

  void removeItem(String itemKey) {
    _items.remove(itemKey);
    notifyListeners();
    _schedulePersist();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
    _schedulePersist();
  }

  String serialize() {
    final map = _items.map((k, v) => MapEntry(k, v.toJson()));
    return json.encode(map);
  }

  void deserialize(String jsonStr) {
    final decoded = json.decode(jsonStr) as Map<String, dynamic>;
    _items.clear();
    decoded.forEach((k, v) {
      _items[k] = CartItem.fromJson(Map<String, dynamic>.from(v as Map));
    });
    notifyListeners();
  }

  Future<void> _restoreFromStorage() async {
    try {
      final str = _persistence.load();
      if (str != null && str.isNotEmpty) {
        deserialize(str);
      }
    } catch (_) {}
  }

  void _schedulePersist() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      try {
        await _persistence.save(serialize());
      } catch (_) {}
    });
  }
}
