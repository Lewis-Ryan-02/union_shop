import 'package:flutter/material.dart';
import 'package:union_shop/helper_widgets.dart';

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
          title: 'Hoodie',
          price: '£25.00',
          discountPrice: '£15.00',
          imageUrl: testUrl),
      ProductCard(
          title: 'Teddy Bear',
          price: '£12.00',
          discountPrice: '£10.00',
          imageUrl: testUrl),
      ProductCard(
          title: 'Notebook',
          price: '£5.99',
          discountPrice: '£3.99',
          imageUrl: testUrl),
      ProductCard(
          title: 'T-Shirt',
          price: '£18.00',
          discountPrice: '£10.00',
          imageUrl: testUrl),
    ]);
  }
}
