import 'package:flutter/material.dart';
import 'package:union_shop/views/product_page.dart';

class TShirtProductPage extends StatelessWidget {
  const TShirtProductPage({super.key});

  static const String path = '/collections/graduation/tshirt';
  static const String title = 'T-Shirt';
  static const String price = '£18.00';
  static const String discountPrice = '';
  static const String description =
      'A comfortable and stylish T-Shirt made from 100% cotton. Perfect for everyday wear.';
  static const String imageUrl = 'assets/images/tshirt.png';

  @override
  Widget build(BuildContext context) {
    return const ProductPage(
      title: title,
      price: price,
      discountPrice: discountPrice,
      description: description,
      imageUrl: imageUrl,
    );
  }
}

class HoodieProductPage extends StatelessWidget {
  const HoodieProductPage({super.key});

  static const String path = '/collections/graduation/hoodie';
  static const String title = 'Hoodie';
  static const String price = '£30.00';
  static const String discountPrice = '';
  static const String description =
      'A warm and cozy hoodie made from high-quality materials. Ideal for chilly days.';
  static const String imageUrl = 'assets/images/hoodie.png';

  @override
  Widget build(BuildContext context) {
    return const ProductPage(
      title: title,
      price: price,
      discountPrice: discountPrice,
      description: description,
      imageUrl: imageUrl,
    );
  }
}

class TeddyBearProductPage extends StatelessWidget {
  const TeddyBearProductPage({super.key});

  static const String path = '/collections/graduation/teddy_bear';
  static const String title = 'Teddy Bear';
  static const String price = '£15.00';
  static const String discountPrice = '';
  static const String description =
      'A soft and cuddly teddy bear, perfect for gifts or as a comforting companion.';
  static const String imageUrl = 'assets/images/teddy.png';

  @override
  Widget build(BuildContext context) {
    return const ProductPage(
      title: title,
      price: price,
      discountPrice: discountPrice,
      description: description,
      imageUrl: imageUrl,
    );
  }
}

class ShoesProductPage extends StatelessWidget {
  const ShoesProductPage({super.key});

  static const String path = '/collections/graduation/shoes';
  static const String title = 'Shoes';
  static const String price = '£7.99';
  static const String discountPrice = '';
  static const String description =
      'A pair of comfortable and stylish shoes, perfect for everyday wear.';
  static const String imageUrl = 'assets/images/shoe.png';

  @override
  Widget build(BuildContext context) {
    return const ProductPage(
      title: title,
      price: price,
      discountPrice: discountPrice,
      description: description,
      imageUrl: imageUrl,
    );
  }
}

class EssentialTShirtProductPage extends StatelessWidget {
  const EssentialTShirtProductPage({super.key});

  static const String path = '/collections/sale/essential_tshirt';
  static const String title = 'Essential T-Shirt';
  static const String price = '£18.00';
  static const String discountPrice = '£10.00';
  static const String description =
      'A comfortable and stylish Essential T-Shirt made from 100% cotton. Perfect for everyday wear.';
  static const String imageUrl = 'assets/images/essentailtshirt.png';

  @override
  Widget build(BuildContext context) {
    return const ProductPage(
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

  static const String path = '/collections/sale/essential_hoodie';
  static const String title = 'Essential Hoodie';
  static const String price = '£25.00';
  static const String discountPrice = '£15.00';
  static const String description =
      'A warm and cozy Essential Hoodie made from high-quality materials. Ideal for chilly days.';
  static const String imageUrl = 'assets/images/essentailhoodie.png';

  @override
  Widget build(BuildContext context) {
    return const ProductPage(
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

  static const String path = '/collections/sale/beenie';
  static const String title = 'Beenie';
  static const String price = '£12.00';
  static const String discountPrice = '£10.00';
  static const String description =
      'A stylish beanie to keep you warm during the colder months.';
  static const String imageUrl = 'assets/images/beenie.png';

  @override
  Widget build(BuildContext context) {
    return const ProductPage(
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

  static const String path = '/collections/sale/jeans';
  static const String title = 'Jeans';
  static const String price = '£5.99';
  static const String discountPrice = '£3.99';
  static const String description =
      'Comfortable and durable jeans suitable for everyday wear.';
  static const String imageUrl = 'assets/images/jeans.png';

  @override
  Widget build(BuildContext context) {
    return const ProductPage(
      title: title,
      price: price,
      discountPrice: discountPrice,
      description: description,
      imageUrl: imageUrl,
    );
  }
}

class PostCardProductPage extends StatelessWidget {
  const PostCardProductPage({super.key});

  static const String path = '/collections/portsmouth-city/postcard';
  static const String title = 'Portsmouth City Postcard';
  static const String price = '£1.00';
  static const String discountPrice = '';
  static const String description =
      'A beautiful postcard to send to your loved ones.';
  static const String imageUrl = 'assets/images/postcard.png';

  @override
  Widget build(BuildContext context) {
    return const ProductPage(
      title: title,
      price: price,
      discountPrice: discountPrice,
      description: description,
      imageUrl: imageUrl,
    );
  }
}

class MagnetProductPage extends StatelessWidget {
  const MagnetProductPage({super.key});

  static const String path = '/collections/portsmouth-city/magnet';
  static const String title = 'Portsmouth City Magnet';
  static const String price = '£4.50';
  static const String discountPrice = '';
  static const String description =
      'A stylish magnet to decorate your fridge or workspace.';
  static const String imageUrl = 'assets/images/magnet.png';

  @override
  Widget build(BuildContext context) {
    return const ProductPage(
      title: title,
      price: price,
      discountPrice: discountPrice,
      description: description,
      imageUrl: imageUrl,
    );
  }
}

class BookmarkProductPage extends StatelessWidget {
  const BookmarkProductPage({super.key});

  static const String path = '/collections/portsmouth-city/bookmark';
  static const String title = 'Portsmouth City Bookmark';
  static const String price = '£3.00';
  static const String discountPrice = '';
  static const String description =
      'A beautiful bookmark to keep your place in your favorite books.';
  static const String imageUrl = 'assets/images/bookmark.png';

  @override
  Widget build(BuildContext context) {
    return const ProductPage(
      title: title,
      price: price,
      discountPrice: discountPrice,
      description: description,
      imageUrl: imageUrl,
    );
  }
}

class NotebookProductPage extends StatelessWidget {
  const NotebookProductPage({super.key});

  static const String path = '/collections/portsmouth-city/notebook';
  static const String title = 'Portsmouth City Notebook';
  static const String price = '£7.50';
  static const String discountPrice = '';
  static const String description =
      'A high-quality notebook to jot down your thoughts and ideas.';
  static const String imageUrl = 'assets/images/notebook.png';

  @override
  Widget build(BuildContext context) {
    return const ProductPage(
      title: title,
      price: price,
      discountPrice: discountPrice,
      description: description,
      imageUrl: imageUrl,
    );
  }
}

class SignatureHoodieProductPage extends StatelessWidget {
  const SignatureHoodieProductPage({super.key});

  static const String path = '/collections/signature-range/signature_hoodie';
  static const String title = 'Signature Hoodie';
  static const String price = '£32.99';
  static const String discountPrice = '£25.00';
  static const String description =
      'A premium quality hoodie from our Signature Range, designed for comfort and style.';
  static const String imageUrl = 'assets/images/signaturehoodie.png';

  @override
  Widget build(BuildContext context) {
    return const ProductPage(
      title: title,
      price: price,
      description: description,
      imageUrl: imageUrl,
    );
  }
}

class SignatureTShirtProductPage extends StatelessWidget {
  const SignatureTShirtProductPage({super.key});

  static const String path = '/collections/signature-range/signature_tshirt';
  static const String title = 'Signature T-Shirt';
  static const String price = '£14.99';
  static const String discountPrice = '£10.00';
  static const String description =
      'A premium quality T-Shirt from our Signature Range, designed for comfort and style.';
  static const String imageUrl = 'assets/images/signaturetshirt.png';

  @override
  Widget build(BuildContext context) {
    return const ProductPage(
      title: title,
      price: price,
      description: description,
      imageUrl: imageUrl,
    );
  }
}