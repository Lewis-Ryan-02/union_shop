import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/helper_widgets.dart';


class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SingleChildScrollView(
      child: Column(
        children: [
          Header(),
          ProductSection(title: 'Collections',
          desktopCount: 3, mobileCount: 2,
          children: [
            ProductOverlay(imageUrl: testUrl, title: 'Graduation'),
            ProductOverlay(imageUrl: testUrl, title: 'Clothing'),
            ProductOverlay(imageUrl: testUrl, title: 'Essential Range'),
            ProductOverlay(imageUrl: testUrl, title: 'Pride Collection'),
            ProductOverlay(imageUrl: testUrl, title: 'SALE'),
            ProductOverlay(imageUrl: testUrl, title: 'Portsmouth City Collection'),
          ]),
          Footer(),
        ],
      ),
    ));
  }
}
