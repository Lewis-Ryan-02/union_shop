import 'package:flutter/material.dart';
import 'package:union_shop/widgets/helper_widgets.dart';
import 'package:union_shop/products.dart';

class PortsmouthCityCollectionPage extends StatelessWidget {
  const PortsmouthCityCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CollectionItemPage(
        title: Text('Portsmouth City Collection'),
        children: [
          ProductCard(
            title: PostCardProductPage.title,
            price: PostCardProductPage.price,
            imageUrl: PostCardProductPage.imageUrl,
            path: PostCardProductPage.path,
          ),
          ProductCard(
            title: MagnetProductPage.title,
            price: MagnetProductPage.price,
            imageUrl: MagnetProductPage.imageUrl,
            path: MagnetProductPage.path,
          ),
          ProductCard(
            title: BookmarkProductPage.title,
            price: BookmarkProductPage.price,
            imageUrl: BookmarkProductPage.imageUrl,
            path: BookmarkProductPage.path,
          ),
          ProductCard(
            title: NotebookProductPage.title,
            price: NotebookProductPage.price,
            imageUrl: NotebookProductPage.imageUrl,
            path: NotebookProductPage.path,
          ),
        ]);
  }
}
