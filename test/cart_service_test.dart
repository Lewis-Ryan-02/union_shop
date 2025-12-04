import 'package:flutter_test/flutter_test.dart';

import 'package:union_shop/cart/cart_service.dart';
import 'package:union_shop/cart/storage/cart_persistence.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InMemoryPersistence extends CartPersistence {
  String? _data;
  InMemoryPersistence() : super(_FakePrefs());

  @override
  Future<void> save(String json) async {
    _data = json;
  }

  @override
  String? load() => _data;

  @override
  Future<void> clear() async {
    _data = null;
  }
}

class _FakePrefs implements SharedPreferences {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('add and merge items with same attributes', () async {
    final persistence = InMemoryPersistence();
    final service = CartService.forTest(persistence);
    service.addItem(
        productId: 'p1',
        name: 'Prod 1',
        unitPrice: 5.0,
        quantity: 1,
        attributes: {'size': 'M'});
    service.addItem(
        productId: 'p1',
        name: 'Prod 1',
        unitPrice: 5.0,
        quantity: 2,
        attributes: {'size': 'M'});
    expect(service.getItems().length, 1);
    expect(service.getItemCount(), 3);
  });

  test('serialize and deserialize roundtrip', () async {
    final persistence = InMemoryPersistence();
    final service = CartService.forTest(persistence);
    service.addItem(
        productId: 'p2', name: 'Prod 2', unitPrice: 2.5, quantity: 2);
    final jsonStr = service.serialize();
    final service2 = CartService.forTest(persistence);
    service2.deserialize(jsonStr);
    expect(service2.getItems().length, 1);
    expect(service2.getItemCount(), 2);
  });

  test('update quantity enforces minimum 1', () async {
    final persistence = InMemoryPersistence();
    final service = CartService.forTest(persistence);
    service.addItem(
        productId: 'p3', name: 'Prod 3', unitPrice: 1.0, quantity: 2);
    final key = service.getItems().first.stableKey();
    service.updateItemQuantity(key, 0);
    expect(service.getItems().first.quantity, 1);
  });
}
