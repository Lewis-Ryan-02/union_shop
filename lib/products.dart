import 'package:flutter/material.dart';
import 'package:union_shop/widgets/helper_widgets.dart';
import 'package:union_shop/views/product_page.dart';

class TShirtProductPage extends StatelessWidget {
  const TShirtProductPage({super.key});

  static const String path = '/collection/graduation/tshirt';
  static const String title = 'T-Shirt';
  static const String price = '£18.00';
  static const String description =
      'A comfortable and stylish T-Shirt made from 100% cotton. Perfect for everyday wear.';
  static const String imageUrl = testUrl;

  @override
  Widget build(BuildContext context) {
    return ProductPage(
      title: title,
      price: price,
      description: description,
      imageUrl: imageUrl,
    );
  }
}

class HoodieProductPage extends StatelessWidget {
  const HoodieProductPage({super.key});

  static const String path = '/collection/graduation/hoodie';
  static const String title = 'Hoodie';
  static const String price = '£30.00';
  static const String description =
      'A warm and cozy hoodie made from high-quality materials. Ideal for chilly days.';
  static const String imageUrl = testUrl;

  @override
  Widget build(BuildContext context) {
    return ProductPage(
      title: title,
      price: price,
      description: description,
      imageUrl: imageUrl,
    );
  }
}

class TeddyBearProductPage extends StatelessWidget {
  const TeddyBearProductPage({super.key});

  static const String path = '/collection/graduation/teddy_bear';
  static const String title = 'Teddy Bear';
  static const String price = '£15.00';
  static const String description =
      'A soft and cuddly teddy bear, perfect for gifts or as a comforting companion.';
  static const String imageUrl = testUrl;

  @override
  Widget build(BuildContext context) {
    return ProductPage(
      title: title,
      price: price,
      description: description,
      imageUrl: imageUrl,
    );
  }
}

class NotebookProductPage extends StatelessWidget {
  const NotebookProductPage({super.key});

  static const String path = '/collection/graduation/notebook';
  static const String title = 'Notebook';
  static const String price = '£7.99';
  static const String description =
      'A high-quality notebook with lined pages, perfect for jotting down notes and ideas.';
  static const String imageUrl = testUrl;

  @override
  Widget build(BuildContext context) {
    return ProductPage(
      title: title,
      price: price,
      description: description,
      imageUrl: imageUrl,
    );
  }
}

class EssentialTShirtProductPage extends StatelessWidget {
  const EssentialTShirtProductPage({super.key});

  static const String path = '/collection/sale/essential_tshirt';
  static const String title = 'Essential T-Shirt';
  static const String price = '£18.00';
  static const String discountPrice = '£10.00';
  static const String description =
      'A comfortable and stylish Essential T-Shirt made from 100% cotton. Perfect for everyday wear.';
  static const String imageUrl = testUrl;

  @override
  Widget build(BuildContext context) {
    return ProductPage(
      title: title,
      price: price,
      discountPrice: discountPrice,
      description: description,
      imageUrl: imageUrl, 
    );
  }
}

class EssentialHoodieProductPage extends StatelessWidget {
  const EssentialHoodieProductPage({super.key});

  static const String path = '/collection/sale/essential_hoodie';
  static const String title = 'Essential Hoodie';
  static const String price = '£25.00';
  static const String discountPrice = '£15.00';
  static const String description =
      'A warm and cozy Essential Hoodie made from high-quality materials. Ideal for chilly days.';
  static const String imageUrl = testUrl;

  @override
  Widget build(BuildContext context) {
    return ProductPage(
      title: title,
      price: price,
      discountPrice: discountPrice,
      description: description,
      imageUrl: imageUrl,
    );
  }
}

class BeenieProductPage extends StatelessWidget {
  const BeenieProductPage({super.key});

  static const String path = '/collection/sale/beenie';
  static const String title = 'Beenie';
  static const String price = '£12.00';
  static const String discountPrice = '£10.00';
  static const String description =
      'A stylish beanie to keep you warm during the colder months.';
  static const String imageUrl = testUrl;

  @override
  Widget build(BuildContext context) {
    return ProductPage(
      title: title,
      price: price,
      discountPrice: discountPrice,
      description: description,
      imageUrl: imageUrl,
    ); 
  }
}

class JeansProductPage extends StatelessWidget {
  const JeansProductPage({super.key});

  static const String path = '/collection/sale/jeans';
  static const String title = 'Jeans';
  static const String price = '£5.99';
  static const String discountPrice = '£3.99';
  static const String description =
      'Comfortable and durable jeans suitable for everyday wear.';
  static const String imageUrl = testUrl;

  @override
  Widget build(BuildContext context) {
    return ProductPage(
      title: title,
      price: price,
      discountPrice: discountPrice,
      description: description,
      imageUrl: imageUrl,
    );
  }
}