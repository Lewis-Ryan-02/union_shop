import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:union_shop/ui/cart/cart_page.dart';
import 'package:union_shop/cart/cart_service.dart';
import 'package:union_shop/cart/storage/cart_persistence.dart';

class _FakePrefs implements SharedPreferences {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

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

void main() {
  group('Cart Page widget tests', () {
    testWidgets('shows empty cart message when no items', (tester) async {
      final persistence = InMemoryPersistence();
      final cartService = CartService.forTest(persistence);

      await tester.pumpWidget(ChangeNotifierProvider.value(
        value: cartService,
        child: const MaterialApp(home: CartPage()),
      ));

      await tester.pumpAndSettle();

      expect(find.text('Your cart is empty'), findsOneWidget);
    });

    testWidgets('displays items and updates quantity', (tester) async {
      final persistence = InMemoryPersistence();
      final cartService = CartService.forTest(persistence);

      // add an item before pumping the widget
      cartService.addItem(
        productId: 'test1',
        name: 'Test Product',
        unitPrice: 10.0,
        quantity: 2,
        attributes: {'color': 'red'},
      );

      await tester.pumpWidget(ChangeNotifierProvider.value(
        value: cartService,
        child: const MaterialApp(home: CartPage()),
      ));

      await tester.pumpAndSettle();

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('Unit: £10.00'), findsOneWidget);
      expect(find.text('2'), findsWidgets); // quantity is shown
      expect(find.text('£20.00'), findsOneWidget); // item total

      // tap the add (+) icon to increase quantity
      final addFinder = find.byIcon(Icons.add_circle_outline).first;
      await tester.tap(addFinder);
      await tester.pumpAndSettle();

      // quantity should increase to 3
      expect(find.text('3'), findsWidgets);
      expect(find.text('£30.00'), findsOneWidget);
    });

    testWidgets('checkout button shows subtotal SnackBar', (tester) async {
      final persistence = InMemoryPersistence();
      final cartService = CartService.forTest(persistence);

      cartService.addItem(
        productId: 't1',
        name: 'Simple',
        unitPrice: 5.5,
        quantity: 1,
      );

      await tester.pumpWidget(ChangeNotifierProvider.value(
        value: cartService,
        child: const MaterialApp(home: CartPage()),
      ));

      await tester.pumpAndSettle();

      // Tap the checkout button
      final checkoutFinder = find.text('Proceed to Checkout');
      expect(checkoutFinder, findsOneWidget);
      await tester.tap(checkoutFinder);
      await tester.pumpAndSettle();

      const expected = 'Items have been checked out';
      expect(find.text(expected), findsOneWidget);
    });
  });
}
