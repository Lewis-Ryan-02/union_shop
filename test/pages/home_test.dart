import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/cart/storage/cart_persistence.dart';
import 'package:union_shop/cart/cart_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  group('Home Page Tests', () {
    testWidgets('should display home page with basic elements', (tester) async {
      final persistence = InMemoryPersistence();
      final cartService = CartService.forTest(persistence);
      await tester.pumpWidget(UnionShopApp(cartService: cartService));
      await tester.pumpAndSettle();

      // Check that basic UI elements are present
      expect(
        find.text(
            'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!'),
        findsOneWidget,
      );
      expect(find.text('Welcome to the Union shop'), findsOneWidget);
      expect(find.text('Your one-stop shop for about three items'),
          findsOneWidget);
      expect(find.text('BROWSE COLLECTIONS'), findsOneWidget);
    });

    testWidgets('should display product cards', (tester) async {
      final persistence = InMemoryPersistence();
      final cartService = CartService.forTest(persistence);
      await tester.pumpWidget(UnionShopApp(cartService: cartService));
      await tester.pumpAndSettle();

      // Check that product cards are displayed
      expect(find.text('Signature Hoodie'), findsOneWidget);
      expect(find.text('Signature T-Shirt'), findsOneWidget);
      expect(find.text('Portsmouth City Postcard'), findsOneWidget);
      expect(find.text('Portsmouth City Notebook'), findsOneWidget);

      // Check prices are displayed
      expect(find.text('£1.00'), findsOneWidget);
      expect(find.text('£7.50'), findsOneWidget);
      // Signature T-Shirt price appears once in the current layout
      expect(find.text('£14.99'), findsOneWidget);
      expect(find.text('£32.99'), findsOneWidget);
    });

    testWidgets('should display header icons', (tester) async {
      final persistence = InMemoryPersistence();
      final cartService = CartService.forTest(persistence);
      await tester.pumpWidget(MediaQuery(
        data: const MediaQueryData(size: Size(390, 844), devicePixelRatio: 1.0),
        child: UnionShopApp(cartService: cartService),
      ));
      await tester.pumpAndSettle();

      // Check that header icons are present
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('should display footer', (tester) async {
      final persistence = InMemoryPersistence();
      final cartService = CartService.forTest(persistence);
      await tester.pumpWidget(UnionShopApp(cartService: cartService));
      await tester.pumpAndSettle();

      // Check that footer is present
      expect(
        find.byKey(const Key('footer_section_left_title')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('footer_section_middle_title')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('footer_section_right_title')),
        findsOneWidget,
      );
    });
  });
}
