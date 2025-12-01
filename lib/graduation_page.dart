import 'package:flutter/material.dart';
import 'package:union_shop/helper_widgets.dart';

class GraduationPage extends StatelessWidget {
  const GraduationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CollectionItemPage(title: Text('Graduation'), children: [
      ProductCard(title: 'Hoodie', price: '£30.00', imageUrl: testUrl),
      ProductCard(title: 'Teddy Bear', price: '£15.00', imageUrl: testUrl),
      ProductCard(title: 'Notebook', price: '£7.99', imageUrl: testUrl),
      ProductCard(title: 'T-Shirt', price: '£20.00', imageUrl: testUrl),
    ]);
  }
}
