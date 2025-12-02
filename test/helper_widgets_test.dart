import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/helper_widgets.dart';

void main() {
  testWidgets('IfWidget shows true branch when condition true', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: IfWidget(
          condition: true,
          isTrue: Text('TRUE'),
          isFalse: Text('FALSE'),
        ),
      ),
    ));

    expect(find.text('TRUE'), findsOneWidget);
    expect(find.text('FALSE'), findsNothing);
  });

  testWidgets('IfWidget shows false branch when condition false',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: IfWidget(
          condition: false,
          isTrue: Text('TRUE'),
          isFalse: Text('FALSE'),
        ),
      ),
    ));

    expect(find.text('FALSE'), findsOneWidget);
    expect(find.text('TRUE'), findsNothing);
  });

  testWidgets('ProductSection renders its children in GridView',
      (tester) async {
    final children = [const Text('A'), const Text('B'), const Text('C')];

    await tester.pumpWidget(MediaQuery(
      data: const MediaQueryData(size: Size(360, 1200)),
      child: MaterialApp(
        home: Scaffold(
            body: SingleChildScrollView(
          child: ProductSection(title: 'Section', children: children),
        )),
      ),
    ));

    await tester.pumpAndSettle();

    expect(find.text('Section'), findsOneWidget);
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
    expect(find.text('C'), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
  });

  testWidgets('ProductCard shows title and price', (tester) async {
    await tester.pumpWidget(const MediaQuery(
      data: MediaQueryData(size: Size(400, 600)),
      child: MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 300,
            child: ProductCard(
                title: 'Test Product',
                price: '£5.00',
                imageUrl: 'assets/images/placeholder_image.png'),
          ),
        ),
      ),
    ));

    await tester.pumpAndSettle();

    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('£5.00'), findsOneWidget);
  });

  testWidgets('ProductOverlay shows title text', (tester) async {
    await tester.pumpWidget(const MediaQuery(
      data: MediaQueryData(size: Size(360, 800)),
      child: MaterialApp(
        home: Scaffold(
            body: SizedBox(
                height: 200,
                child: ProductOverlay(
                    title: 'Overlay Title',
                    imageUrl: 'assets/images/placeholder_image.png'))),
      ),
    ));

    await tester.pumpAndSettle();

    expect(find.text('Overlay Title'), findsOneWidget);
  });

  testWidgets(
      'CollectionItemPage contains Header and Footer and shows children count',
      (tester) async {
    final children = [const Text('Item1'), const Text('Item2')];
    // Ensure the test surface is large enough to avoid horizontal overflow
    await tester.binding.setSurfaceSize(const Size(1200, 1600));
    addTearDown(() async {
      // Restore to a reasonable default for other tests
      await tester.binding.setSurfaceSize(const Size(800, 600));
    });

    await tester.pumpWidget(MediaQuery(
      data: const MediaQueryData(size: Size(1200, 1600)),
      child: MaterialApp(
        home: CollectionItemPage(
            title: const Text('My Collection'), children: children),
      ),
    ));

    await tester.pumpAndSettle();

    // Header banner text should be present
    expect(find.textContaining('BIG SALE!'), findsOneWidget);

    // Footer section keys should be present
    expect(find.byKey(const Key('footer_section_left_title')), findsOneWidget);
    expect(
        find.byKey(const Key('footer_section_middle_title')), findsOneWidget);
    expect(find.byKey(const Key('footer_section_right_title')), findsOneWidget);

    // Children are included in the product section
    expect(find.text('Item1'), findsOneWidget);
    expect(find.text('Item2'), findsOneWidget);
  });
}
