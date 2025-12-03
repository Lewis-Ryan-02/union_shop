import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/print_shack.dart';

void main() {
  group('PrintShackPage widget tests', () {
    testWidgets('Initial UI - title, price, fields and button present',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PrintShackPage()));
      await tester.pumpAndSettle();

      expect(find.text('Make your Own Print Shack Product'), findsOneWidget);
      expect(find.text('Add to Cart'), findsOneWidget);
      // initial dynamic line field should be present (label shown as Text widget)
      expect(find.text('Line 1'), findsOneWidget);
      // quantity label should be visible below fields
      expect(find.text('Quantity'), findsOneWidget);
      // ensure at least one TextField exists for line input and one numeric TextField for quantity
      expect(find.byType(TextField), findsWidgets);
      expect(
        find.byWidgetPredicate(
            (w) => w is TextField && w.keyboardType == TextInputType.number),
        findsOneWidget,
      );
    });

    testWidgets('Dropdown is present and displays initial selection',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PrintShackPage()));
      await tester.pumpAndSettle();

      // Ensure the 'Number of lines' label and initial selection text are visible
      expect(find.text('Number of lines'), findsOneWidget);
      expect(find.text('One line'), findsWidgets);
    });

    testWidgets('Enter text in line fields and quantity then tap Add to Cart',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PrintShackPage()));
      await tester.pumpAndSettle();

      // Type into the first TextField (Line 1)
      final firstField = find.byType(TextField).first;
      await tester.enterText(firstField, 'Custom Name');
      await tester.pumpAndSettle();

      // Enter quantity into the last TextField (quantity field)
      await tester.enterText(find.byType(TextField).last, '2');
      await tester.pumpAndSettle();

      // Tap Add to Cart and ensure button exists and is tappable
      final addToCart = find.text('Add to Cart');
      expect(addToCart, findsOneWidget);
      await tester.tap(addToCart);
      await tester.pumpAndSettle();

      // If no exceptions, the basic interaction is successful
      expect(find.text('Add to Cart'), findsOneWidget);
    });

    testWidgets('Responsive layout adapts to narrow width',
        (WidgetTester tester) async {
      // Set a small screen size using the supported API
      await tester.binding.setSurfaceSize(const Size(400, 800));

      await tester.pumpWidget(const MaterialApp(home: PrintShackPage()));
      await tester.pumpAndSettle();

      // On narrow layouts the image column is shown above details in the mobile branch
      expect(find.text('Make your Own Print Shack Product'), findsOneWidget);

      // Restore surface size after the test
      addTearDown(() async {
        await tester.binding.setSurfaceSize(null);
      });
    });
  });
}
