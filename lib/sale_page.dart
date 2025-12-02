import 'package:flutter/material.dart';
import 'package:union_shop/helper_widgets.dart';
import 'package:union_shop/products.dart';

class SalePage extends StatelessWidget {
  const SalePage({super.key});

  final Widget title = const Column(
    children: [
      Text('SALE'),
      SizedBox(height: 8),
      Text(
        'Buy the items at a discount today!',
        style: TextStyle(fontSize: 16),
      ),
      Icon(Icons.local_offer)
    ],
  );

  @override
  Widget build(BuildContext context) {
    return CollectionItemPage(title: title, children: const [
      ProductCard(
          title: EssentialHoodieProductPage.title,
          price: EssentialHoodieProductPage.price,
          discountPrice: EssentialHoodieProductPage.discountPrice,
          imageUrl: EssentialHoodieProductPage.imageUrl,
          path: EssentialHoodieProductPage.path),
      ProductCard(
          title: BeenieProductPage.title,
          price: BeenieProductPage.price,
          discountPrice: BeenieProductPage.discountPrice,
          imageUrl: BeenieProductPage.imageUrl,
          path: BeenieProductPage.path),
      ProductCard(
          title: JeansProductPage.title,
          price: JeansProductPage.price,
          discountPrice: JeansProductPage.discountPrice,
          imageUrl: JeansProductPage.imageUrl,
          path: JeansProductPage.path),
      ProductCard(
          title: EssentialTShirtProductPage.title,
          price: EssentialTShirtProductPage.price,
          discountPrice: EssentialTShirtProductPage.discountPrice,
          imageUrl:EssentialTShirtProductPage.imageUrl,
          path: EssentialTShirtProductPage.path),
    ]);
  }
}
