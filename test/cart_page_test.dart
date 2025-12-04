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

    testWidgets('long-pressing an item removes it from the cart',
        (tester) async {
      final persistence = InMemoryPersistence();
      final cartService = CartService.forTest(persistence);

      cartService.addItem(
        productId: 'lp1',
        name: 'Long Press Product',
        unitPrice: 4.0,
        quantity: 1,
      );

      await tester.pumpWidget(ChangeNotifierProvider.value(
        value: cartService,
        child: const MaterialApp(home: CartPage()),
      ));

      await tester.pumpAndSettle();

      expect(find.text('Long Press Product'), findsOneWidget);

      // Long press the card containing the product name
      final inkFinder = find.ancestor(
          of: find.text('Long Press Product'), matching: find.byType(InkWell));
      expect(inkFinder, findsOneWidget);

      await tester.longPress(inkFinder);
      // Allow the framework to process the gesture and any scheduled timers
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pumpAndSettle();

      // After removal, cart should be empty
      expect(find.text('Your cart is empty'), findsOneWidget);
    });

    testWidgets('decrement button does not reduce quantity below 1',
        (tester) async {
      final persistence = InMemoryPersistence();
      final cartService = CartService.forTest(persistence);

      cartService.addItem(
        productId: 'dq1',
        name: 'Decrement Product',
        unitPrice: 3.0,
        quantity: 1,
      );

      await tester.pumpWidget(ChangeNotifierProvider.value(
        value: cartService,
        child: const MaterialApp(home: CartPage()),
      ));

      await tester.pumpAndSettle();

      // Find the remove (-) icon and tap it
      final removeFinder = find.byIcon(Icons.remove_circle_outline).first;
      await tester.tap(removeFinder);
      await tester.pumpAndSettle();

      // Quantity should remain at 1 and subtotal at £3.00
      expect(find.text('1'), findsWidgets);
      expect(find.text('£3.00'), findsOneWidget);
    });

    testWidgets('persistence saves and can be restored', (tester) async {
      final persistence = InMemoryPersistence();
      final cartService = CartService.forTest(persistence);

      cartService.addItem(
        productId: 'p1',
        name: 'Persisted',
        unitPrice: 2.5,
        quantity: 2,
      );

      // Wait for debounce to write
      await tester.pump(const Duration(milliseconds: 350));

      expect(persistence.load(), isNotNull);

      // Create a new service and deserialize saved data
      final restored = CartService.forTest(persistence);
      restored.deserialize(persistence.load()!);

      expect(restored.getItems().length, equals(1));
      final item = restored.getItems().first;
      expect(item.name, equals('Persisted'));
      expect(item.quantity, equals(2));
      expect(restored.getSubtotal(), equals(5.0));
    });

    testWidgets('attributes display and subtotal updates on quantity change',
        (tester) async {
      final persistence = InMemoryPersistence();
      final cartService = CartService.forTest(persistence);

      cartService.addItem(
        productId: 'a1',
        name: 'Attr Product',
        unitPrice: 7.5,
        quantity: 1,
        attributes: {'color': 'blue', 'size': 'M'},
      );

      await tester.pumpWidget(ChangeNotifierProvider.value(
        value: cartService,
        child: const MaterialApp(home: CartPage()),
      ));

      await tester.pumpAndSettle();

      // Attributes should be shown
      expect(find.textContaining('color: blue'), findsOneWidget);
      expect(find.textContaining('size: M'), findsOneWidget);

      // Increase quantity
      final addFinder = find.byIcon(Icons.add_circle_outline).first;
      await tester.tap(addFinder);
      await tester.pumpAndSettle();

      // Subtotal should update to 15.00
      expect(find.text('£15.00'), findsOneWidget);
    });
  });
}
