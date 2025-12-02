import 'package:flutter/material.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/widgets/helper_widgets.dart';


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
            ProductOverlay(imageUrl: testUrl, title: 'Graduation', path: '/collections/graduation'),
            ProductOverlay(imageUrl: testUrl, title: 'Signiture Range', path: '/collections/signature-range'),
            ProductOverlay(imageUrl: testUrl, title: 'SALE', path: '/collections/sale'),
            ProductOverlay(imageUrl: testUrl, title: 'Portsmouth City Collection', path: '/collections/portsmouth-city'),
          ]),
          Footer(),
        ],
      ),
    ));
  }
}
