import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/collections.dart';

void main() {
  testWidgets('Collections Page displays product overlays', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: CollectionsPage(),
      ),
    ));

    await tester.pumpAndSettle();

    // Check that all product overlays are present
    expect(find.text('Graduation'), findsOneWidget);
    expect(find.text('Clothing'), findsOneWidget);
    expect(find.text('Essential Range'), findsOneWidget);
    expect(find.text('Pride Collection 🏳️‍🌈'), findsOneWidget);
    expect(find.text('SALE'), findsOneWidget);
    expect(find.text('Portsmouth City Collection'), findsOneWidget);
  });
}