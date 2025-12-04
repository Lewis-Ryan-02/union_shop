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

  test('removeItem and clearCart behave correctly', () async {
    final persistence = InMemoryPersistence();
    final service = CartService.forTest(persistence);
    service.addItem(
        productId: 'r1', name: 'RemoveMe', unitPrice: 2.0, quantity: 1);
    service.addItem(
        productId: 'r2', name: 'KeepMe', unitPrice: 3.0, quantity: 1);
    expect(service.getItems().length, 2);

    final key =
        service.getItems().firstWhere((i) => i.productId == 'r1').stableKey();
    service.removeItem(key);
    expect(service.getItems().length, 1);

    service.clearCart();
    expect(service.getItems().isEmpty, isTrue);
  });

  test('updateItemAttributes merges items with matching attributes', () async {
    final persistence = InMemoryPersistence();
    final service = CartService.forTest(persistence);

    // Add two items with same productId but different attributes
    service.addItem(
        productId: 'm1',
        name: 'MergeMe',
        unitPrice: 5.0,
        quantity: 1,
        attributes: {'color': 'red'});
    service.addItem(
        productId: 'm1',
        name: 'MergeMe',
        unitPrice: 5.0,
        quantity: 2,
        attributes: {'color': 'blue'});

    expect(service.getItems().length, 2);

    // Change first item's attributes to match the second; they should merge
    final firstKey = service.getItems().first.stableKey();
    service.updateItemAttributes(firstKey, {'color': 'blue'});

    expect(service.getItems().length, 1);
    expect(service.getItemCount(), 3);
  });

  test('subtotal, tax and total calculations are accurate', () async {
    final persistence = InMemoryPersistence();
    final service = CartService.forTest(persistence);
    service.addItem(productId: 'c1', name: 'C1', unitPrice: 10.0, quantity: 1);
    service.addItem(productId: 'c2', name: 'C2', unitPrice: 2.5, quantity: 2);

    expect(service.getSubtotal(), closeTo(15.0, 0.001));
    expect(service.getTax(0.1), closeTo(1.5, 0.001));
    expect(service.getTotal(0.1), closeTo(16.5, 0.001));
  });
}
