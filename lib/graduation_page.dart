import 'package:flutter/material.dart';
import 'package:union_shop/helper_widgets.dart';
import 'package:union_shop/products.dart';

class GraduationPage extends StatelessWidget {
  const GraduationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CollectionItemPage(title: Text('Graduation'), children: [
      ProductCard(
          title: HoodieProductPage.title,
          price: HoodieProductPage.price,
          imageUrl: HoodieProductPage.imageUrl,
          path: HoodieProductPage.path),
      ProductCard(
          title: TeddyBearProductPage.title,
          price: TeddyBearProductPage.price,
          imageUrl: TeddyBearProductPage.imageUrl,
          path: TeddyBearProductPage.path),
      ProductCard(
          title: NotebookProductPage.title,
          price: NotebookProductPage.price,
          imageUrl: NotebookProductPage.imageUrl,
          path: NotebookProductPage.path),
      ProductCard(
          title: TShirtProductPage.title,
          price: TShirtProductPage.price,
          imageUrl: TShirtProductPage.imageUrl,
          path: TShirtProductPage.path),
    ]);
  }
}
