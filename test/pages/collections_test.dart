import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/collections.dart';

void main() {
  testWidgets('Collections Page displays product overlays', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: CollectionsPage(),
      ),
    ));

    await tester.pumpAndSettle();

    // Check that all product overlays present in the current UI
    expect(find.text('Graduation'), findsOneWidget);
    // Header currently shows the shop overlay titled 'Signiture Range' (note spelling)
    expect(find.text('Signiture Range'), findsOneWidget);
    expect(find.text('SALE'), findsOneWidget);
    expect(find.text('Portsmouth City Collection'), findsOneWidget);
  });
}
