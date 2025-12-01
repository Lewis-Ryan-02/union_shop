import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';

void main() {
  group('Home Page Tests', () {
    testWidgets('should display home page with basic elements', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Check that basic UI elements are present
      expect(
        find.text('BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!'),
        findsOneWidget,
      );
      expect(find.text('Welcome to the Union shop'), findsOneWidget);
      expect(find.text('Your one-stop shop for about three items'), findsOneWidget);
      expect(find.text('BROWSE COLLECTIONS'), findsOneWidget);
    });

    testWidgets('should display product cards', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Check that product cards are displayed
      expect(find.text('Signature Hoodie'), findsOneWidget);
      expect(find.text('Signature T-Shirt'), findsOneWidget);
      expect(find.text('Portsmouth City Postcard'), findsOneWidget);
      expect(find.text('Portsmouth City Notebook'), findsOneWidget);

      // Check prices are displayed
      expect(find.text('£1.00'), findsOneWidget);
      expect(find.text('£7.50'), findsOneWidget);
      expect(find.text('£14.99'), findsExactly(2));
      expect(find.text('£32.99'), findsOneWidget);
    });

    testWidgets('should display header icons', (tester) async {
      await tester.pumpWidget(const MediaQuery(
        data: MediaQueryData(size: Size(390, 844), devicePixelRatio: 1.0),
        child: UnionShopApp(),
      ));
      await tester.pump();

      // Check that header icons are present
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('should display footer', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

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
