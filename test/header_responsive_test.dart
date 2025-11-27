import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/header_drawer.dart';

void main() {
  testWidgets('Header shows mobile layout (menu icon) at 360px',
      (tester) async {
    const size = Size(360, 800);
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(size: size, devicePixelRatio: 1.0),
        child: MaterialApp(
          home: Scaffold(
            drawer: HeaderDrawer(),
            body: Header(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // On mobile we expect a menu icon button to be present
    expect(find.byIcon(Icons.menu), findsOneWidget);

    // Desktop dropdowns should not be visible on mobile
    expect(find.byType(DropdownButton), findsNothing);
  });

  testWidgets('Header shows desktop layout (dropdowns) at 1366px',
      (tester) async {
    const size = Size(1366, 900);
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(size: size, devicePixelRatio: 1.0),
        child: MaterialApp(
          home: Scaffold(
            body: Header(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // On desktop we expect the selected shop label to be visible
    expect(find.text('shop'), findsOneWidget);

    // Menu icon should not be present in desktop layout
    expect(find.byIcon(Icons.menu), findsNothing);
  });

  testWidgets('Tapping menu opens Drawer on mobile', (tester) async {
    const size = Size(360, 800);
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(size: size, devicePixelRatio: 1.0),
        child: MaterialApp(
          home: Scaffold(
            drawer: HeaderDrawer(),
            body: Header(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final menuFinder = find.byIcon(Icons.menu);
    expect(menuFinder, findsOneWidget);

    await tester.tap(menuFinder, warnIfMissed: false);
    await tester.pumpAndSettle();

    // DrawerHeader contains the title 'Union Shop'
    expect(find.text('Union Shop'), findsOneWidget);
  });
}
