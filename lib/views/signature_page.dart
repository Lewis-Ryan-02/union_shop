import 'package:flutter/material.dart';
import 'package:union_shop/products.dart';
import 'package:union_shop/widgets/helper_widgets.dart';

class SignaturePage extends StatelessWidget {
  const SignaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CollectionItemPage(title: Text('Signature collection'), children: [
      ProductCard(
          title: SignatureHoodieProductPage.title,
          price: SignatureHoodieProductPage.price,
          discountPrice: SignatureHoodieProductPage.discountPrice,
          imageUrl: SignatureHoodieProductPage.imageUrl,),
      ProductCard(
          title: SignatureTShirtProductPage.title,
          price: SignatureTShirtProductPage.price,
          discountPrice: SignatureTShirtProductPage.discountPrice,
          imageUrl: SignatureTShirtProductPage.imageUrl,),
    ]);
  }
}
