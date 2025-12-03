import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/print_shack_about.dart';

void main() {
  group('PrintShackAboutPage widget tests', () {
    testWidgets('Renders title, gallery icon and content',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PrintShackAboutPage()));
      await tester.pumpAndSettle();

      expect(find.text('The Union Print Shack'), findsOneWidget);
      // center gallery uses a print icon in the middle
      expect(find.byIcon(Icons.print), findsOneWidget);
      expect(
          find.text('Make It Yours at The Union Print Shack'), findsOneWidget);
      expect(find.text('Uni Gear or Your Gear - We\'ll Personalise It'),
          findsOneWidget);
    });

    testWidgets('Page is scrollable and content remains visible',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PrintShackAboutPage()));
      await tester.pumpAndSettle();

      // Ensure the title is visible before scrolling
      expect(find.text('The Union Print Shack'), findsOneWidget);

      // Try scrolling down the page to ensure no exceptions (scroll by fling)
      await tester.fling(
          find.byType(SingleChildScrollView), const Offset(0, -300), 1000);
      await tester.pumpAndSettle();

      // After scroll the title should still be present in the tree
      expect(find.text('The Union Print Shack'), findsOneWidget);
    });

    testWidgets('Layout adapts to narrow screen widths',
        (WidgetTester tester) async {
      // Use supported API to set a small surface size
      await tester.binding.setSurfaceSize(const Size(360, 800));

      await tester.pumpWidget(const MaterialApp(home: PrintShackAboutPage()));
      await tester.pumpAndSettle();

      // Title should still be visible
      expect(find.text('The Union Print Shack'), findsOneWidget);

      addTearDown(() async {
        await tester.binding.setSurfaceSize(null);
      });
    });
  });
}
