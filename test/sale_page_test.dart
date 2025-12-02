import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/sale_page.dart';

void main() {
  testWidgets('Sale Page displays product cards with discounts', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: SalePage(),
      ),
    ));

    await tester.pumpAndSettle();

    expect(find.text('Buy the items at a discount today!'), findsOneWidget);

    // Check that all product cards are present
    expect(find.text('Hoodie'), findsOneWidget);
    expect(find.text('£25.00'), findsOneWidget);
    expect(find.text('£15.00'), findsOneWidget);

    expect(find.text('Teddy Bear'), findsOneWidget);
    expect(find.text('£12.00'), findsOneWidget);
    expect(find.text('£10.00'), findsExactly(2));

    expect(find.text('Notebook'), findsOneWidget);
    expect(find.text('£5.99'), findsOneWidget);
    expect(find.text('£3.99'), findsOneWidget);

    expect(find.text('T-Shirt'), findsOneWidget);
    expect(find.text('£18.00'), findsOneWidget);
    expect(find.text('£10.00'), findsExactly(2));
  });
}