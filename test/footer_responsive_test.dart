import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/footer.dart';

void main() {
  testWidgets('Footer renders Column on mobile width 360',
      (WidgetTester tester) async {
    const width = 360.0;
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: Size(width, 800)),
          child: Scaffold(body: Footer()),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Expect section titles and email/subscribe exist on mobile
    expect(find.byKey(const Key('footer_section_left_title')), findsOneWidget);
    expect(
        find.byKey(const Key('footer_section_middle_title')), findsOneWidget);
    expect(find.byKey(const Key('footer_section_right_title')), findsOneWidget);
    expect(find.byKey(const Key('footer_email_field')), findsOneWidget);
    expect(find.byKey(const Key('footer_subscribe_button')), findsOneWidget);
  });

  testWidgets(
      'Footer renders Row with three Expanded children at desktop width 1366',
      (WidgetTester tester) async {
    const width = 1366.0;
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: Size(width, 800)),
          child: Scaffold(body: Footer()),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Find a Row inside the scaffold and ensure it has Expanded children (3 main sections)
    final rowFinder =
        find.descendant(of: find.byType(Scaffold), matching: find.byType(Row));
    expect(rowFinder, findsOneWidget);

    final expandedFinder =
        find.descendant(of: rowFinder, matching: find.byType(Expanded));
    expect(expandedFinder, findsNWidgets(3));

    // Ensure all section titles and controls are present on desktop as well
    expect(find.byKey(const Key('footer_section_left_title')), findsOneWidget);
    expect(
        find.byKey(const Key('footer_section_middle_title')), findsOneWidget);
    expect(find.byKey(const Key('footer_section_right_title')), findsOneWidget);
    expect(find.byKey(const Key('footer_email_field')), findsOneWidget);
    expect(find.byKey(const Key('footer_subscribe_button')), findsOneWidget);
  });

  testWidgets('Subscribe clears email field', (WidgetTester tester) async {
    const width = 768.0;
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: Size(width, 800)),
          child: Scaffold(body: Footer()),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final emailField = find.byKey(const Key('footer_email_field'));
    final subscribeButton = find.byKey(const Key('footer_subscribe_button'));

    expect(emailField, findsOneWidget);
    expect(subscribeButton, findsOneWidget);

    await tester.enterText(emailField, 'test@example.com');
    expect(find.text('test@example.com'), findsOneWidget);

    await tester.tap(subscribeButton);
    await tester.pumpAndSettle();

    expect(find.text('test@example.com'), findsNothing);
  });
}
