import 'package:flutter/material.dart';
import 'package:union_shop/widgets/helper_widgets.dart';
import 'package:union_shop/widgets/responsive.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/products.dart';


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
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: Image.asset(
                            testUrl
                          ).image,
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
                          'Welcome to the Union shop',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Your one-stop shop for about three items",
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
                              Navigator.pushNamed(context, '/collections'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4d2963),
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: const Text(
                            'BROWSE COLLECTIONS',
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
                  title: EssentialHoodieProductPage.title,
                  price: EssentialHoodieProductPage.price,
                  discountPrice: EssentialHoodieProductPage.discountPrice,
                  imageUrl:
                      EssentialHoodieProductPage.imageUrl,
                ),
                ProductCard(
                  title: EssentialTShirtProductPage.title,
                  price: EssentialTShirtProductPage.price,
                  discountPrice: EssentialTShirtProductPage.discountPrice,
                  imageUrl:
                      EssentialTShirtProductPage.imageUrl,
                ),
              ],
            ),
            const SizedBox(height: 48),
            const ProductSection(title: 'Signature range', children: [
              ProductCard(
                title: 'Signature Hoodie',
                price: '£32.99',
                imageUrl:
                    testUrl,
              ),
              ProductCard(
                title: 'Signature T-Shirt',
                price: '£14.99',
                imageUrl:
                    testUrl,
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
                      testUrl,
                ),
                ProductCard(
                  title: 'Portsmouth City Magnet',
                  price: '£4.50',
                  imageUrl:
                      testUrl,
                ),
                ProductCard(
                  title: 'Portsmouth City Bookmark',
                  price: '£3.00',
                  imageUrl:
                      testUrl,
                ),
                ProductCard(
                  title: 'Portsmouth City Notebook',
                  price: '£7.50',
                  imageUrl:
                      testUrl,
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
                          testUrl),
                  ProductOverlay(
                      title: 'Merchandise',
                      imageUrl:
                          testUrl),
                  ProductOverlay(
                      title: 'Graduation',
                      path: '/collections/graduation',
                      imageUrl:
                          testUrl),
                  ProductOverlay(
                      title: 'Sale',
                      path: '/collections/sale',
                      imageUrl:
                          testUrl),
                ]),

            const SizedBox(height: 48),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: isDesktop(context) ? 2 : 1,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const Image(
                  image: AssetImage(
                      testUrl),
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