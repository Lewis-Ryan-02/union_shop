import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:union_shop/main.dart';
import 'package:union_shop/products.dart';
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
  testWidgets(
      'full cart flow: add from collection + print shack, modify, delete, checkout',
      (tester) async {
    final persistence = InMemoryPersistence();
    final cartService = CartService.forTest(persistence);

    await tester.pumpWidget(UnionShopApp(cartService: cartService));
    await tester.pumpAndSettle();

    // 1) Add Signature T-Shirt from home (collection)
    final tshirtFinder = find.text(SignatureTShirtProductPage.title);
    expect(tshirtFinder, findsOneWidget);
    await tester.ensureVisible(tshirtFinder);
    await tester.pumpAndSettle();
    await tester.tap(tshirtFinder);
    await tester.pumpAndSettle();

    // On product page, tap Add to Cart
    final addBtn = find.text('Add to Cart');
    expect(addBtn, findsOneWidget);
    await tester.ensureVisible(addBtn);
    await tester.pumpAndSettle();
    await tester.tap(addBtn);
    await tester.pumpAndSettle();

    // Verify cart service has one item
    expect(cartService.getItemCount(), 1);

    // Return to home (use Navigator.pop to avoid platform-specific back button expectations)
    final navState = tester.state<NavigatorState>(find.byType(Navigator));
    navState.pop();
    await tester.pumpAndSettle();

    // 2) Navigate to Print Shack page directly (header menu isn't present in desktop tests)
    final navState2 = tester.state<NavigatorState>(find.byType(Navigator));
    navState2.pushNamed('/print-shack');
    await tester.pumpAndSettle();

    // On PrintShackPage, tap Add to Cart (uses custom product name)
    final addPrintBtn = find.text('Add to Cart');
    expect(addPrintBtn, findsOneWidget);
    await tester.ensureVisible(addPrintBtn);
    await tester.pumpAndSettle();
    await tester.tap(addPrintBtn);
    await tester.pumpAndSettle();

    // Now cart should have 2 items total (1 + 1)
    expect(cartService.getItemCount(), 2);

    // 3) Navigate to cart route
    final nav = tester.state<NavigatorState>(find.byType(Navigator));
    nav.pushNamed('/cart');
    await tester.pumpAndSettle();

    // Both items should appear in the cart UI
    expect(find.text(SignatureTShirtProductPage.title), findsOneWidget);
    expect(find.text('Custom Print Shack Product'), findsOneWidget);

    // Change attributes of the Signature T-Shirt (via the injected cartService)
    final sigItem = cartService
        .getItems()
        .firstWhere((i) => i.name == SignatureTShirtProductPage.title);
    final sigKey = sigItem.stableKey();
    cartService.updateItemAttributes(sigKey, {'size': 'L', 'color': 'black'});
    // Allow debounce/persist timers to run and UI to update
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pumpAndSettle();

    // The cart UI should show the updated attributes
    expect(find.textContaining('size: L'), findsOneWidget);
    expect(find.textContaining('color: black'), findsOneWidget);

    // 4) Increase quantity of Signature T-Shirt by tapping its + button inside the card
    final sigText = find.text('Signature T-Shirt');
    final sigCard = find.ancestor(of: sigText, matching: find.byType(Card));
    expect(sigCard, findsOneWidget);
    final sigAdd = find.descendant(
        of: sigCard, matching: find.byIcon(Icons.add_circle_outline));
    expect(sigAdd, findsOneWidget);
    await tester.tap(sigAdd);
    await tester.pumpAndSettle();

    // quantity should now be 2 for that item; total item count 3
    expect(cartService.getItemCount(), 3);

    // 5) Remove the print shack item by long pressing its name's card
    final printText = find.text('Custom Print Shack Product');
    final printCard = find.ancestor(of: printText, matching: find.byType(Card));
    expect(printCard, findsOneWidget);
    await tester.longPress(printCard);
    // allow debounce/persist timers to run after removal
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pumpAndSettle();

    // The print item should be gone
    expect(find.text('Custom Print Shack Product'), findsNothing);

    // Cart count should reflect removal (was 3, remove 1 -> 2)
    expect(cartService.getItemCount(), 2);

    // 6) Tap Proceed to Checkout and verify snack bar with subtotal
    final checkoutBtn = find.text('Proceed to Checkout');
    expect(checkoutBtn, findsOneWidget);
    await tester.ensureVisible(checkoutBtn);
    await tester.pumpAndSettle();
    await tester.tap(checkoutBtn);
    // allow SnackBar animation to start
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    // The app should show a SnackBar confirming checkout (text may vary)
    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets(
      'alternate cart flow: add two sale items, modify attrs, remove one, checkout',
      (tester) async {
    final persistence = InMemoryPersistence();
    final cartService = CartService.forTest(persistence);

    await tester.pumpWidget(UnionShopApp(cartService: cartService));
    await tester.pumpAndSettle();

    // Navigate to Sale collection
    final navState = tester.state<NavigatorState>(find.byType(Navigator));
    navState.pushNamed('/collections/sale');
    await tester.pumpAndSettle();

    // Add Essential Hoodie
    final hoodieFinder = find.text(EssentialHoodieProductPage.title);
    expect(hoodieFinder, findsOneWidget);
    await tester.ensureVisible(hoodieFinder);
    await tester.tap(hoodieFinder);
    await tester.pumpAndSettle();
    final addBtn = find.text('Add to Cart');
    expect(addBtn, findsOneWidget);
    await tester.tap(addBtn);
    await tester.pumpAndSettle();

    // Back to sale page
    tester.state<NavigatorState>(find.byType(Navigator));
    navState.pop();
    await tester.pumpAndSettle();

    // Add Beenie
    final beenieFinder = find.text('Beenie');
    expect(beenieFinder, findsOneWidget);
    await tester.ensureVisible(beenieFinder);
    await tester.tap(beenieFinder);
    await tester.pumpAndSettle();
    expect(addBtn, findsOneWidget);
    await tester.tap(addBtn);
    await tester.pumpAndSettle();

    // Go to cart
    final nav = tester.state<NavigatorState>(find.byType(Navigator));
    nav.pushNamed('/cart');
    await tester.pumpAndSettle();

    // Both items present
    expect(find.text(EssentialHoodieProductPage.title), findsOneWidget);
    expect(find.text(BeenieProductPage.title), findsOneWidget);

    // Modify attributes of Beenie via cartService (simulate selecting color)
    final beenieItem = cartService
        .getItems()
        .firstWhere((i) => i.name == BeenieProductPage.title);
    final beenieKey = beenieItem.stableKey();
    cartService.updateItemAttributes(beenieKey, {'color': 'green'});
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pumpAndSettle();

    expect(find.textContaining('color: green'), findsOneWidget);

    // Increase hoodie quantity
    final hoodieText = find.text(EssentialHoodieProductPage.title);
    final hoodieCard =
        find.ancestor(of: hoodieText, matching: find.byType(Card));
    final hoodieAdd = find.descendant(
        of: hoodieCard, matching: find.byIcon(Icons.add_circle_outline));
    expect(hoodieAdd, findsOneWidget);
    await tester.tap(hoodieAdd);
    await tester.pumpAndSettle();
    expect(cartService.getItemCount(), 3);

    // Remove Beenie by long press
    final beenieText = find.text(BeenieProductPage.title);
    final beenieCard =
        find.ancestor(of: beenieText, matching: find.byType(Card));
    expect(beenieCard, findsOneWidget);
    await tester.longPress(beenieCard);
    // allow debounce/persist timers
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pumpAndSettle();

    expect(find.text('Beenie'), findsNothing);

    // Checkout
    final checkoutBtn = find.text('Proceed to Checkout');
    expect(checkoutBtn, findsOneWidget);
    await tester.tap(checkoutBtn);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
