import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/about_page.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/responsive.dart';
import 'package:union_shop/helper_widgets.dart';
import 'package:union_shop/sign_in_page.dart';

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      home: const HomeScreen(),
      // By default, the app starts at the '/' route, which is the HomeScreen
      initialRoute: '/',
      // When navigating to '/product', build and return the ProductPage
      // In your browser, try this link: http://localhost:49856/#/product
      routes: {
        '/product': (context) => const ProductPage(),
        '/about': (context) => const AboutPage(),
        '/signin' : (context) => SignInScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void navigateToAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            const Header(),

            // Hero Section
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ),
                  // Content overlay
                  Positioned(
                    left: 24,
                    right: 24,
                    top: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Placeholder Hero Title',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "This is placeholder text for the hero section.",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/product'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4d2963),
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: const Text(
                            'BROWSE PRODUCTS',
                            style: TextStyle(fontSize: 14, letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),
            const Text(
              'PRODUCTS SECTION',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 48),
            // Products Section
            const ProductSection(
              title: 'Essentials Range - over 20% off!',
              mobileCount: 1,
              desktopCount: 2,
              children: [
                ProductCard(
                  title: 'Limited Edition Essential Zipper Hoodies',
                  price: '£14.99',
                  discountPrice: '£20.00',
                  imageUrl:
                      'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                ),
                ProductCard(
                  title: 'Essential T-Shirt',
                  price: '£6.99',
                  discountPrice: '£10.00',
                  imageUrl:
                      'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                ),
              ],
            ),
            const SizedBox(height: 48),
            const ProductSection(title: 'Signature range', children: [
              ProductCard(
                title: 'Signature Hoodie',
                price: '£32.99',
                imageUrl:
                    'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
              ),
              ProductCard(
                title: 'Signature T-Shirt',
                price: '£14.99',
                imageUrl:
                    'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
              ),
            ]),

            const SizedBox(height: 48),
            const ProductSection(
              title: 'Portsmouth City Collection',
              children: [
                ProductCard(
                  title: 'Portsmouth City Postcard',
                  price: '£1.00',
                  imageUrl:
                      'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                ),
                ProductCard(
                  title: 'Portsmouth City Magnet',
                  price: '£4.50',
                  imageUrl:
                      'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                ),
                ProductCard(
                  title: 'Portsmouth City Bookmark',
                  price: '£3.00',
                  imageUrl:
                      'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                ),
                ProductCard(
                  title: 'Portsmouth City Notebook',
                  price: '£7.50',
                  imageUrl:
                      'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                ),
              ],
            ),

            const SizedBox(height: 48 * 2),
            ElevatedButton(
              onPressed: () {
                navigateToProduct(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4d2963),
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Text(
                'View All',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 48 * 2),

            const ProductSection(
                title: 'Our Range',
                desktopCount: 4,
                mobileCount: 2,
                children: [
                  ProductOverlay(
                      title: 'Clothing',
                      imageUrl:
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282'),
                  ProductOverlay(
                      title: 'Merchandise',
                      imageUrl:
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282'),
                  ProductOverlay(
                      title: 'Graduation',
                      imageUrl:
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282'),
                  ProductOverlay(
                      title: 'Sale',
                      imageUrl:
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282'),
                ]),

            const SizedBox(height: 48),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: isDesktop(context) ? 2 : 1,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const Image(
                  image: NetworkImage(
                      'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Add a personal touch'),
                      const SizedBox(height: 16),
                      const Text('First add your item of clothing to your cart\nthen click below to add your text! One line of\ntext contains 10 characters!'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Click Here to add text!'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Footer
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class ProductOverlay extends StatelessWidget {
  const ProductOverlay(
      {super.key, required this.imageUrl, required this.title});

  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  imageUrl,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
        // Content overlay
        Positioned(
          left: 24,
          right: 24,
          top: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }
}

class ProductSection extends StatelessWidget {
  const ProductSection(
      {super.key,
      required this.title,
      required this.children,
      this.mobileCount = 1,
      this.desktopCount = 2,
      this.crossSpacing = 24,
      this.mainSpacing = 48});

  final String title;
  final List<Widget> children;
  final int mobileCount;
  final int desktopCount;
  final double crossSpacing;
  final double mainSpacing;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isDesktop(context) ? desktopCount : mobileCount,
              crossAxisSpacing: crossSpacing,
              mainAxisSpacing: mainSpacing,
              children: children,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String discountPrice;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.discountPrice = '',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              IfWidget(
                  isFalse: Text(
                    price,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  isTrue: Row(
                    children: [
                      Text(
                        discountPrice,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        price,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  condition: discountPrice.isNotEmpty),
            ],
          ),
        ],
      ),
    );
  }
}
