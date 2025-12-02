import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/product_page.dart';

void main() {
  group('ProductPage responsive', () {
    testWidgets('mobile layout stacks content (360 width)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(360, 800));
      addTearDown(() async {
        await tester.binding.setSurfaceSize(const Size(800, 600));
      });

      await tester.pumpWidget(MaterialApp(
          home: ProductPage(
        title: 'Test Product',
        description: 'Test Description',
        price: '£15.00',
      )));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('productImage')), findsOneWidget);
      expect(find.byKey(const Key('productDetails')), findsOneWidget);

      // ensure stacked: productImage appears before productDetails in the tree
      final image = find.byKey(const Key('productImage'));
      final details = find.byKey(const Key('productDetails'));
      expect(
          tester.getTopLeft(image).dy <= tester.getTopLeft(details).dy, isTrue);

      // no fatal assertions here; header overflow is tested separately in header tests
    });

    testWidgets('desktop medium width shows side-by-side (768 width)',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(768, 900));
      addTearDown(() async {
        await tester.binding.setSurfaceSize(const Size(800, 600));
      });

      await tester.pumpWidget(MaterialApp(
          home: ProductPage(
        title: 'Test Product',
        description: 'Test Description',
        price: '£15.00',
      )));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('productImage')), findsOneWidget);
      expect(find.byKey(const Key('productDetails')), findsOneWidget);

      final image = find.byKey(const Key('productImage'));
      final details = find.byKey(const Key('productDetails'));

      // On desktop the image should be to the left of details (x coordinate smaller)
      expect(
          tester.getTopLeft(image).dx < tester.getTopLeft(details).dx, isTrue);

      // not asserting global exceptions here (header tested elsewhere)
    });

    testWidgets('desktop wide width shows side-by-side (1366 width)',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(1366, 900));
      addTearDown(() async {
        await tester.binding.setSurfaceSize(const Size(800, 600));
      });

      await tester.pumpWidget(MaterialApp(
          home: ProductPage(
        title: 'Test Product',
        description: 'Test Description',
        price: '£15.00',
      )));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('productImage')), findsOneWidget);
      expect(find.byKey(const Key('productDetails')), findsOneWidget);

      final image = find.byKey(const Key('productImage'));
      final details = find.byKey(const Key('productDetails'));

      expect(
          tester.getTopLeft(image).dx < tester.getTopLeft(details).dx, isTrue);
      // not asserting global exceptions here (header tested elsewhere)
    });
  });
}
