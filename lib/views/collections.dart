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
            ProductOverlay(imageUrl: 'assets/images/gradrange.png', title: 'Graduation', path: '/collections/graduation'),
            ProductOverlay(imageUrl: 'assets/images/sigrange.png', title: 'Signiture Range', path: '/collections/signature-range'),
            ProductOverlay(imageUrl: 'assets/images/sale.png', title: 'SALE', path: '/collections/sale'),
            ProductOverlay(imageUrl: 'assets/images/sigrange.png', title: 'Portsmouth City Collection', path: '/collections/portsmouth-city'),
          ]),
          Footer(),
        ],
      ),
    ));
  }
}
