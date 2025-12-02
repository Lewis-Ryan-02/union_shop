import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/product_page.dart';

void main() {
  group('Product Page Tests', () {
    Widget createTestWidget() {
      return MaterialApp(
          home: ProductPage(
              title: 'Placeholder Product Name',
              description:
                  'This is a placeholder description for the product. Students should replace this with real product information and implement proper data management.',
              price: '£15.00', discountPrice: '£10.00'));
    }

    testWidgets('should display product page with basic elements', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that basic UI elements are present
      expect(
        find.text(
            'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!'),
        findsOneWidget,
      );
      expect(find.text('Placeholder Product Name'), findsOneWidget);
      expect(find.text('£15.00'), findsOneWidget);
      expect(find.text('£10.00'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
    });

    testWidgets('should display student instruction text', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that student instruction is present
      expect(
        find.text(
          'This is a placeholder description for the product. Students should replace this with real product information and implement proper data management.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('should display header icons', (tester) async {
      await tester.pumpWidget(MediaQuery(
        data: const MediaQueryData(size: Size(390, 844), devicePixelRatio: 1.0),
        child: createTestWidget(),
      ));
      await tester.pump();

      // Check that header icons are present
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('should display footer', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that footer is present
      expect(
          find.byKey(const Key('footer_section_left_title')), findsOneWidget);
      expect(
          find.byKey(const Key('footer_section_middle_title')), findsOneWidget);
      expect(
          find.byKey(const Key('footer_section_right_title')), findsOneWidget);
    });
  });
}
